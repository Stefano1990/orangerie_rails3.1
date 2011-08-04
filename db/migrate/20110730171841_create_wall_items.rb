class CreateWallItems < ActiveRecord::Migration
  def change
    create_table  :wall_items do |t|
      t.integer   :item_id
      t.string    :item_type
      t.integer   :user_id
      t.datetime  :deleted_at

      t.timestamps
    end
  end
end
