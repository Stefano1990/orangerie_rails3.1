class MessagesController < ApplicationController
  
  #before_filter :authenticate_user!
  #before_filter :valid_user?, :only => :show
  
  respond_to :html
  layout "users"
  
  def show
    @message.mark_as_read if current_user?(@message.recipient)
    respond_to do |format|
      format.html
    end
  end
  
  def new
    @user = !params[:user_id].nil? ? User.find(params[:user_id]) : current_user
    @message = Message.new
    respond_to do |format|
      format.html { render :layout => "users" }
    end
  end
  
  def index
    @user = current_user
    @conversations = Conversation.conversations_for_user(@user).reverse
    # OLD SYSTEM
    # @messages_all = current_user.recieved_messages
    # @messages = @messages_all.paginate(:page => params[:page], :per_page => params[:per_page])
    respond_with @conversations
  end
  
  # GET /messages/sent
  def sent
    @user = current_user
    @messages_all = current_user.sent_messages(params[:page])
    @messages = @messages_all
    respond_to do |format|
      format.html { render :template => "messages/index", :layout => "users" }
    end 
  end
  
  # GET /messages/trash
  def trash
    @user = current_user
    @messages = current_user.trashed_messages(params[:page])
    respond_to do |format|
      format.html { render :template => "messages/index", :layout => "users" }
    end
  end
  
  def reply
    @user = User.find(current_user)
    original_message = Message.find(params[:id])
    
    # mark the message as read
    original_message.mark_as_read if current_user?(original_message.recipient)
    recipient = original_message.other_user(current_user)
    
    @message = Message.unsafe_build(:parent_id    => original_message.id,
                                    :subject      => original_message.subject,
                                    :sender       => current_user,
                                    :recipient    => recipient)
    
    @conversation = original_message.conversation.not_trashed_messages(@user)
    
    @recipient = not_current_user(original_message)
    respond_to do |format|
      format.html { render :action => "new", :layout => "users" }
    end
  end
  
  def create
    
    @message = Message.new(params[:message])
    @message.sender = current_user
    @message.recipient = User.find(params[:message][:recipient_tokens])
  
    if reply?
      @message.parent = Message.find(params[:message][:parent_id])
      @message.conversation = @message.parent.conversation
      redirect_to home_url and return unless @message.valid_reply?
      
      if @message.save
        respond_to do |format|
          flash[:success] = 'Message sent!'
          format.html { render :action => "new", :layout => "users" }
          format.js
        end
      end
    else
      if @message.save
        respond_to do |format|
          flash[:success] = 'Message sent!'
          format.html { redirect_to reply_message_path(@message) }
        end
      end
    end
  end
    
  def destroy
    @message = Message.find(params[:id])
    if @message.trash(current_user)
      flash[:success] = "Message trashed"
    else
      # This should never happen...
      flash[:error] = "Invalid action"
    end

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.js
    end
  end
  
  def undestroy
    @message = Message.find(params[:id])
    if @message.untrash(current_user)
      flash[:success] = "Message restored to inbox"
    else
      # This should never happen...
      flash[:error] = "Invalid action"
    end
    respond_to do |format|
      format.html { redirect_to messages_url }
    end
  end
  
  def recipients
    @recipients = User.where("name like ?", "%#{params[:q]}%").select("name, id")
    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { render :json => @recipients.map(&:attributes) }
    end
  end
  
  private
        def setup
          @body = "messages"
        end
        
        def valid_user?
          @message = Message.find(params[:id])
          unless (current_user == @message.sender or
                  current_user == @message.recipient)
            redirect_to new_user_session_path
          end
        end
        
        def current_user?(user)
          current_user == user
        end
        
        def not_current_user(message)
          message.sender == current_user ? message.recipient : message.sender
        end
        
        def reply?
          not params[:message][:parent_id].nil?
        end
        
        def preview?
          params["commit"] == "Preview"
        end
end
