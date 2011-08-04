class PagesController < ApplicationController
  def show
    @user = current_user
    # This could be removed later because 'custom' pages have special routes to them anyway. 
    # therefore this if/else is likely not to be needed.
    if Page::SPECIAL_PAGES.include?(params[:id])
      render "pages/#{params[:id]}"
    else
      unless params[:lang].nil?
        @page = Page.where(:id  => params[:id], :lang => params[:lang]).first # seems like a dirty hack, but might work.
      else
        @page = Page.find(params[:id]) rescue @page = Page.find_by_url(params[:id])
      end
    end
  end
  
  def home
    @user = current_user
  end  
end
