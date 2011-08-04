class Admin::FlagsController < ApplicationController
  def index
    flags = Flag.where(:flaggable_type => "Post" )
    @posts = []
    flags.each do |f|
      @posts << f.flaggable
    end
  end
end