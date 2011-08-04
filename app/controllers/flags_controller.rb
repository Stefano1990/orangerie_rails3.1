class FlagsController < ApplicationController
  respond_to :html, :js
  
  def create
    if Flag.create(params[:flag])
      flash[:notice] = "#{params[:flag][:flaggable_type]} has been flagged and will be reviewed."
      redirect_to :back
    end
  end
end
