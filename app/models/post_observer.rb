class PostObserver < ActiveRecord::Observer
  def after_save(post)
    # Doesnt strictly have anything to do with the actual post, therefore its in the activity observer.
    Activity.create!(:item => post, :user => post.user)
    
    # send a notification to the owner of the post. IF its not the own user.
    if post.user != post.owner
      Notification.create!(:user => post.owner, :contact => post.user, :item => post)
    end
  end
end
