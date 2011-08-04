class Chatmessage < ActiveRecord::Base
  belongs_to                :user
  
  validates_length_of       :body, :within => 1...200
  validates_presence_of     :body
  
  
  
end
