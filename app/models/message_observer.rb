class MessageObserver < ActiveRecord::Observer
  def after_save(message)
    # creates a notification for the reciever.
    Notification.create!(:user => message.recipient, :contact => message.sender, :item => message)
  end 
end