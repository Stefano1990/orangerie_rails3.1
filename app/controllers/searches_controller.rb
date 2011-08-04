class SearchesController < ApplicationController
  def search
    
  end
  
  def index
    @results = Comment.search(params[:text])
    @results.reject_nil
  end
end
