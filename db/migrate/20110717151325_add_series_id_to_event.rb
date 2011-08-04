class AddSeriesIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :series_id, :integer
  end
end
