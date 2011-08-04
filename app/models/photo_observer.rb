class PhotoObserver < ActiveRecord::Observer
  def after_save(photo)
    # Doesnt strictly have anything to do with the actual post, therefore its in the activity observer.
    activity = Activity.create!(:item => photo, :user => photo.user, :include_user => false)
  end
end
