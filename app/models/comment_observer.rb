class CommentObserver < ActiveRecord::Observer
  def after_save(comment)
    # Doesnt strictly have anything to do with the actual post, therefore its in the activity observer.
    activity = Activity.create!(:item => comment, :user => comment.user)
    
    # creates a notification for all the users who have commented on the thing that the user has commented on.
    # example: user1 comments on a pic of user2
    # user2 gets notification.
    # uesr3 comments on same pic.
    # user1 and user2 get a notification.
    users = Comment.where(:commentable_id => comment.commentable.id).map(&:user).reject{|u| u==comment.user}.uniq
    #if comment.commentable_type == "Post" # This should be changed.
    #  users << comment.commentable.user
    #else
    #  users << comment.commentable.user
    #end
    
    Comment.transaction do
      users.each do |user|
        Notification.create!(:user => user, :contact => comment.user, :item => comment)
      end
    end
  end
end