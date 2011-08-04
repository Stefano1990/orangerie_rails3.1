class Category < ActiveRecord::Base
  attr_accessible       :name, :position
  
  validates_presence_of :name, :position
  
  has_many :pages
end
