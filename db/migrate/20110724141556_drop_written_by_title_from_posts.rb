class DropWrittenByTitleFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :written_by
    remove_column :posts, :title
  end
end
