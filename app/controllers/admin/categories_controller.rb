class Admin::CategoriesController < ApplicationController
  layout "admin"
  
  def index
    @categories = Category.all(:order => "position ASC")
    respond_to do |format|
      format.html { render :action => :index}
    end
  end
  
  def create
    @category = Category.new(params[:category])
    if @category.save
      respond_to do |format|
        flash[:success] = "Page created."
        format.html { redirect_to admin_categories_path }
      end
    else
      respond_to do |format|
        format.html { render :action => :new}
      end
    end
  end
  
  def move_up
    @category = Category.find(params[:id])
    @category.position -= 1
    if @category.save
      @categories = Category.all(:order => "position ASC")
      respond_to do |format|
        format.html { render :action => :index}
        format.js
      end
    end
  end
  
  def move_down
    @category = Category.find(params[:id])
    @category.position += 1
    if @category.save
      @categories = Category.all(:order => "position ASC")
      respond_to do |format|
        format.html { render :action => :index, :layout => "admin"}
        format.js
      end
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash[:success] = "Category destroyed"
      respond_to do |format|
        format.html { redirect_to admin_categories_path }
      end
    end
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update_attributes!(params[:category])
      flash[:success] = "Updated."
      render :edit
    else
      render :edit
    end
  end
end
