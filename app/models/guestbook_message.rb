class GuestbookMessage < ActiveRecord::Base
  attr_accessible     :title, :body
  validates           :title, :body, :user_id, :presence => true
  
  belongs_to          :user
  # The :admin is the user who wrote the answer.
  belongs_to          :admin, :foreign_key => "answer_user_id", :class_name => "User"
  
  def has_answer?
    !answered_at.nil?
  end
end
