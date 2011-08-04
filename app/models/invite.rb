class Invite < ActiveRecord::Base
  belongs_to      :user, :foreign_key => "user_id", :class_name => "User"
  belongs_to      :contact, :foreign_key => "contact_id", :class_name => "User"
  belongs_to      :invitable, :polymorphic => true
  
  class << self 
    
    def friends_not_coming(invitable, user)
      friends = user.contacts # the contacts of the user
      friends_invited_by_user = friends.reject{|friend| Invite.find_all_by_user_id(user).map{|inv| inv.contact}.include?(friend)}
      
      # then needs to filter out the people who already have a reservation.
      friends_invited_by_user = friends_invited_by_user.reject{|friend| invitable.reservations.map{|res| res.user}.include?(friend)}
    end
    
    def invite_friends(invitable, user, friend_ids)
      friend_ids.each do |k,v|
        invite = Invite.new(:user_id => user.id, :contact_id => v, :wall_publish => true)
        invite.invitable = invitable
        invite.save
      end
    end
    
    def make_wall_post(invitable, user)
      wall_post = Invite.new(:user => user, :contact => user, :wall_publish => true)
      wall_post.invitable = invitable
      wall_post.save
    end
  end
end