class AddWrittenByToPost < ActiveRecord::Migration
  def change
    add_column :posts, :written_by, :string, :default => "User"
  end
end
