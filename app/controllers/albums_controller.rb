class AlbumsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :trusted
  #before_filter :authorize, :except => [:show, :new, :create, :setup]
  
  respond_to :html, :json, :js
  layout "users"
  
  def index
    @user = User.find(params[:user_id])
    respond_with(@user.albums)
  end
  
  def show
    @user = User.find(params[:user_id])
    @album = @user.albums.find(params[:id])
    @photos = @album.photos
    respond_to do |format|
      format.html { render :action => :show, :layout => "users" }
    end
  end
  
  def new
    @user = current_user
    @album = @user.albums.new
    respond_to do |format|
      format.html { render :action => :new, :layout => "users" }
    end
  end

  def create
    @user = User.find(params[:user_id])
    @album = @user.albums.new(params[:album])
    if @album.save
      flash[:success] = t('albums.flash.albums.created')
      respond_to do |format|
        format.html { redirect_to user_albums_path(@user) }
      end
    else
      flash[:error] = t('albums.flash.albums.not_created')
      respond_to do |format|
        format.html { render :action => :new, :layout => "users" }
      end
    end
  end
  
  def edit
    @album = Album.find(params[:id])
    @user = User.find(params[:user_id])
    @photos = @album.photos
    respond_with @album
  end
  
  def update
    @user = User.find(params[:user_id])
    @album = @user.albums.find(params[:id])
    if @album.update_attributes!(params[:album])
      flash[:success] = t('users.flash.albums.updated')
      respond_to do |format|
        format.html { redirect_to user_album_photos_path(@user, @album) }
        format.js
      end
    else
      render :edit
    end
  end
  
  def destroy
    @album = Album.find(params[:id])
    @user = @album.user
    if @album.destroy
      flash[:success] = t('users.flash.albums.destroyed')
      respond_to do |format|
        format.html { redirect_to user_photos_path(@user) }
      end
    else  
      flash[:error] = t('users.flash.albums.destroyed')
      redirect_to user_path(@post.owner)
    end
  end
  
  private
  
      ## Before filters            
      def trusted
        redirect_to trusted_user_path(current_user) unless current_user.trusted
      end
      
      def authorize
        user = User.find(params[:user_id])
        redirect_to user_path(user) unless current_user == user
      end
end
