class ChatmessagesController < ApplicationController
  respond_to  :js, :html
  
  def create
    @chat_message = Chatmessage.new(params[:chatmessage])
    @chat_message.user = current_user
    @chat_message.save
  end
  
  def show
  end
end
