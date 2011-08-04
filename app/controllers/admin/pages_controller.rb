class Admin::PagesController < ApplicationController
  def index
    @pages = Page.all
    respond_to do |format|
      format.html { render :layout => "admin" }
    end
  end
  
  def new
    @page = Page.new
    respond_to do |format|
      format.html { render :layout => "admin" }
    end
  end
  
  def create
    @page = Page.new(params[:page])
    if @page.save
      respond_to do |format|
        flash[:success] = "Page created."
        format.html { redirect_to admin_pages_path }
      end
    else
      respond_to do |format|
        format.html { render :action => :new, :layout => "admin"}
      end
    end
  end
  
  def edit
    @user = current_user
    @page = Page.find(params[:id])
    respond_to do |format|
      format.html { render :action => :edit, :layout => "admin"}
    end
  end
  
  def destroy
    @page = Page.find(params[:id])
    if @page.destroy
      flash[:notice] = "Page was destroyed."
      respond_to do |format|
        format.html { redirect_to admin_pages_path }
        format.js
      end
    end
  end
  
  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      flash[:success] = "success."
      redirect_to @page
    else
      render :edit
    end
  end
  
  def move_up
    @page = Page.find(params[:id])
    @page.position -= 1
    if @page.save
      @category = @page.category
      respond_to do |format|
        format.html { render :controller => :categories, :action => :edit }
        format.js
      end
    end
  end
  
  def move_down
    @page = Page.find(params[:id])
    @page.position += 1
    if @page.save
      @pages = Page.all(:order => "position ASC")
      respond_to do |format|
        format.html { render :action => :index, :layout => "admin"}
        format.js
      end
    end
  end
  
  private
  
        def authorize_admin
          if user_signed_in?
            redirect_to(root_path) unless current_user.admin
          else
            redirect_to(root_path)
          end
        end
end