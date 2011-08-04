class Admin::CommentsController < ApplicationController
  def index
    
    # Params [:commentable] are defined:
    if !params[:commentable].nil?
      @comments = Comment.where(:commentable_type => params[:commentable], :commentable_id => params[:commentable_id])
    end
    @flagged_comments = Comment.where(:flagged => true).all
    @search = Search.new
  end
end