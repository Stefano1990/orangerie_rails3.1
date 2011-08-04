class CreateGuestbookMessages < ActiveRecord::Migration
  def change
    create_table :guestbook_messages do |t|
      t.integer :user_id
      t.string :title
      t.text :body
      t.integer :answer_user_id
      t.text :answer_body
      t.datetime :answered_at

      t.timestamps
    end
  end
end
