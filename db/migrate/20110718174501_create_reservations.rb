class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :guests_male, :default => 0
      t.integer :guests_female, :default => 0
      t.text :remarks

      t.timestamps
    end
  end
end
