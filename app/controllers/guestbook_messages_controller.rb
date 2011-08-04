class GuestbookMessagesController < ApplicationController
  # TODO: I18n for all the flash messages.
  
  def index
    @guestbook_message = GuestbookMessage.new
    @messages = GuestbookMessage.all.reverse
  end

  def show
  end

  def new
  end

  def create
    @guestbook_message = GuestbookMessage.new(params[:guestbook_message])
    @guestbook_message.user = current_user
    if @guestbook_message.save
      flash[:success] = "guestbook entry made."
      respond_to do |format|
        format.html
        format.js
      end
    else
      flash[:error] = "guestbook entry was not saved."
      render redirect_to guestbook_messages_path
    end
  end

  def edit
  end

  def destroy
  end

end
