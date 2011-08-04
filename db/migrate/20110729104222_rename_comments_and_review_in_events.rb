class RenameCommentsAndReviewInEvents < ActiveRecord::Migration
  def change
    rename_column :events, :comments, :has_comments
    rename_column :events, :review, :is_review
  end
end
