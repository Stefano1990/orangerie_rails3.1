class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :short_description
      t.text :long_description
      t.boolean :comments
      t.datetime :date
      t.integer :price_male
      t.integer :price_female
      t.integer :price_couple
      t.integer :discount

      t.timestamps
    end
  end
end
