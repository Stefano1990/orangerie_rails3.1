class PostsController < ApplicationController
  layout "users"
  def create
    @post = current_user.posts.build(params[:post])
    @user = current_user
    unless @post.owner == @post.user
      @user_to_notify = @post.owner
    end
    if @post.save
      flash[:success] = t('users.flash.wall_post_created')
      respond_to do |format|
        format.html { redirect_to user_path(@post.owner) }
        format.js
      end
    else
      flash[:error] = t('users.flash.wall_post_created')
      redirect_to user_path(@post.owner)
    end
  end
  
  def show
    @user = current_user
    @post = Post.find(params[:id])
  end
  
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = t('users.flash.wall_post_destroyed')
      respond_to do |format|
        format.html { redirect_to user_path(@post.wall_id) }
        format.js
      end
    else  
      flash[:error] = t('users.flash.wall_post_error')
      redirect_to user_path(@post.owner)
    end
  end

end
