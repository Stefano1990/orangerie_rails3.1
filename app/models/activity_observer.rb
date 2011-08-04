class ActivityObserver < ActiveRecord::Observer
  def after_save(activity, include_user = false)
    user = activity.user
    users_ids = users_to_add(user, activity, include_user)
    do_livestream_insert(users_ids, activity.id) unless users_ids.empty?
    
    # TODO: finish this up.
    # activity gets set to read, since the user knows that me makes a post or a comment.
    # But the activity has to be created so the livestream includes his own activities.
    # set_activity_to_read(activity) if activity_type(activity) == "Post" or activity_type(activity) == "Comment"
  end
  
  private
      # Return the ids of the users whose livestreams need to be updated.
      # The key step is the subtraction of users who already have the activity.
      def users_to_add(user, activity, include_user)
        all = user.contacts.map(&:id)
        all.push(user.id) if include_user
        all - already_have_activity(all, activity)
      end
    
      # Return the ids of users who already have the given livestream activity.
      # The results of the query are livestream objects with only a user_id
      # attribute (due to the "DISTINCT user_id" clause), which we extract
      # using map(&:user_id).
      def already_have_activity(users, activity)
        Livestream.all(:select => "DISTINCT user_id",
                        :conditions => ["user_id IN (?) AND activity_id = ?",
                                        users, activity]).map(&:user_id)    
      end
      
      # Convert an array of values into an SQL string.
      # For example, [[1, 2], [3, 4]] becomes "(1,2), (3, 4)".
      # This does no escaping since it currently only needs to work with ints.
      def convert_to_sql(array_of_values)
        array_of_values.inspect[1...-1].gsub('[', '(').gsub(']', ')')
      end

      # Revised function to not having to write custom SQL.
      def do_livestream_insert(user_ids, activity_id)
        Livestream.transaction do
          user_ids.each do |user_id|
            Livestream.create(:user_id => user_id, :activity_id => activity_id)
          end
        end
      end
      
      #def do_livestream_insert(users_ids, activity_id)
      #  users_ids.each do |k,v|
      #    sql = %(INSERT INTO livestreams (user_id, activity_id) 
      #          VALUES (#{k}, #{activity_id}))
      #    ActiveRecord::Base.connection.execute(sql)
      #  end
      #end

      def set_activity_to_read(activity)
       activity.read = true
       activity.save
      end

      def activity_type(activity)
        activity.item.class.to_s      
      end
end
