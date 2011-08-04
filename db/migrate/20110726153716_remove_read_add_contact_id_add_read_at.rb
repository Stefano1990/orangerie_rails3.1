class RemoveReadAddContactIdAddReadAt < ActiveRecord::Migration
  def change
    add_column    :notifications, :contact_id, :integer  
  end
end
