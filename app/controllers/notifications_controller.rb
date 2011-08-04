class NotificationsController < ApplicationController
  def index
    # shows the notifications for a user.
    @notifications = current_user.notifications
  end
end