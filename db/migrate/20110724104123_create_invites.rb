class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :user_id
      t.integer :contact_id
      t.boolean :wall_publish
      t.text :body
      t.integer :invitable
      t.string :invitable_type

      t.timestamps
    end
  end
end
