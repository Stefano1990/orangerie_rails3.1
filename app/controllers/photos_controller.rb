class PhotosController < ApplicationController
  before_filter :authenticate_user!
  before_filter :valid_user?, :only => [:new, :create, :destroy ]
  respond_to :html, :json, :js
  layout 'users'
  
  def index
    @user = User.find(params[:user_id])
    @album = @user.albums.find(params[:album_id])
    @photos = @album.photos
    respond_with @photos
  end
  
  def show
    @user = User.find(params[:user_id])
    @album = @user.albums.find(params[:album_id])
    @photo = @album.photos.find(params[:id])
    #  @photos = @album.photos.paginate(:page => params[:page], :per_page => 1)
    #  @photo = @photos.first
    respond_to do |format|
      format.html { render :action => :show, :layout => "users" }
    end
  end
  
  def new
    @user = current_user
    @photo = current_user.photos.new
    respond_to do |format|
      format.html { render :action => :new, :layout => "users" }
    end
  end
  
  def create
    user = current_user
    @photo = Photo.new(params[:photo])
    @photo.user = user
    if @photo.save
      flash[:success] = "awesome."
      redirect_to user_album_photo_path(@photo.user, @photo.album, @photo)
    else
      flash[:error] = "not so awesome."
      redirect_to user_path(user)
    end
  end
  
  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(params[:photo])
      respond_with @photo
    end
  end
  
  def destroy
    @photo = Photo.find(params[:id])
    @user = @photo.user
    @album = @photo.album
    if @photo.destroy
      flash[:success] = t('users.flash.wall_post_destroyed')
      respond_to do |format|
        format.html { redirect_to user_album_path(@user, @album) }
      end
    else  
      flash[:error] = t('users.flash.wall_post_error')
      redirect_to user_path(@post.owner)
    end
  end
  
  def make_avatar
    @photo = Photo.find(params[:photo_id])
    @user = @photo.user
    # FIXME: Refactor this controller.
    # checks if the current user is the owner of the photo viewed.
    if current_user == @photo.user
      @user.avatar_id = @photo.id
      if @user.save
        flash[:success] = "Avatar was changed."
        redirect_to :back
      else
        flash[:error] = "Avatar was not changed."
        redirect_to :back
      end
    else
      flash[:error] = "Not allowed."
    end
  end
  
  private
  
      def valid_user?
        unless User.find(params[:user_id]) == current_user
          redirect_to user_path(params[:user_id])
        end
      end
      
     
      
end
