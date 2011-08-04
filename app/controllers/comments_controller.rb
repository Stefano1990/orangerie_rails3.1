class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :trusted
  before_filter :authorize_destroy, :except => [:index, :create]
  #before_filter :friends, :except => [:index, :show]
  before_filter :redirect_back
  
  def index
    @commentable = find_commentable
    @comments = @commentable.comments
  end
  
  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment])
    @comment.user = current_user
    if @comment.save
      flash[:success] = t('comments.flash.created')
      # finds the users it has to send a notification to.
      @users_to_notify = Comment.where(:commentable_id => @comment.commentable.id).map(&:user).reject{|u| u==@comment.user}.uniq
      @users_to_notify << @comment.commentable.user unless @comment.commentable.user == current_user
      @users_to_notify = @users_to_notify.uniq
      respond_to do |format|
        format.html { redirect_to session[:return_to] }
        format.js
      end
    else
      flash[:error] = t('comments.flash.created_error')
      redirect_to session[:return_to]
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:notice] = t('comments.flash.destroyed')
      respond_to do |format|
        format.html { redirect_to session[:return_to] }
        format.js
      end
    end
  end
  
  private
      def find_commentable
        params.each do |name, value|
          if name =~ /(.+)_id$/
            return $1.classify.constantize.find(value)
          end
        end
        nil
      end
      
      def redirect_back
        session[:return_to] = request.referer
      end
      
      def authorize_create
        @post = Post.find(params[:post_id])
        post_owner = @post.user
        wall_owner = @post.owner
        unless is_friend?(wall_owner) or own_wall?(wall_owner)
          flash[:error] = t('comments.flash.not_allowed')
          redirect_to user_path(wall_owner)
        end
      end
      
      def authorize_destroy
        @comment = Comment.find(params[:id])
        redirect_to user_path(@comment.commentable.owner) unless @comment.user == current_user
      end
      
      def friends?(post_owner)
        Connection.accepted?(current_user, post_owner)
      end
      
      def own_wall?(wall_owner)
        current_user == wall_owner
      end
      
      def trusted
        redirect_to trusted_user_path(current_user) unless current_user.trusted
      end
end
