class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :valid_user?,   :except =>  [:edit, :update]
  before_filter :user_trusted?, :except =>  [:edit, :update, :infos, :show, :trusted]
  before_filter :own_profile?,  :only =>    [:edit]
  before_filter :are_friends?,  :except =>  [:edit, :update, :show, :infos, :friends, :trusted]
  #before_filter :is_trusted_or_own_profile?, :except => [:create, :update, :edit ]
  #before_filter :valid_user?, :except => [:edit, :update]
  #before_filter :user_trusted?, :except => [:edit, :update]
  #before_filter :correct_user, :except => [:show, :infos, :freunde, :fotos]
  respond_to :html, :js
  
  def index
    #should get called purely for testing purposes.
    @users = User.paginate :page => params[:page], :order => 'created_at DESC'
  end
  
  def wall
    @user = User.find(params[:id])
    @posts = @user.wall_posts
    
    #create the stream
    @offset = params[:offset] || 0
    @stream = @user.make_stream(@offset)
    @commentable = find_commentable  
    respond_with(@user)
  end
  
  def friends
    @user = User.find(params[:id])
    @contacts = @user.contacts
    respond_with(@user)
  end
  
  def infos
    @user = User.find(params[:id])
    @infos = @user.infos
    respond_with(@user)
  end
  
  def fotos
     @user = User.find(params[:id])
     respond_with(@user)
  end
  
  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(params[:id])
    @infos = @user.infos
    if @infos.update_attributes(params[:user][:infos_attributes])
      flash[:success] = t('users.flash.user_updated')
      redirect_to infos_user_path(@user)
    else
      render :edit
    end
  end
  
  def livestream
    @user = current_user
    @offset = params[:offset] || 0
    @livestream = @user.make_livestream(@offset)
  end
  
  def orangerie_fan
    @user = current_user
    respond_with(@user)
  end

  private
  
      def create_stream(user)
        stream = user.posts + user.activities
        stream.sort! {|x,y| y.created_at <=> x.created_at }
      end
      # A user is valid if he has filled out the minimum information about his profile
      def valid_user?
        redirect_to(edit_user_path(current_user)) if current_user.infos.sex.blank?
      end
      
      def user_trusted?
        redirect_to trusted_user_path unless current_user.trusted
      end
      
      def own_profile?
        user = User.find(params[:id])
        unless current_user == user
          flash[:error] = I18n.t('users.flash.not_allowed')
          redirect_to user_path(user)
        end
      end
      
      def are_friends?
        user = User.find(params[:id])
        unless user == current_user
          unless Connection.accepted?(current_user, user)
            redirect_to user_path(user)
          end
        end
      end

      def find_commentable
        params.each do |name, value|
          if name =~ /(.+)_id$/
            return $1.classify.constantize.find(value)
          end
        end
        nil
      end
      
      
end
