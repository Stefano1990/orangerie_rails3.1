class AddLangToPages < ActiveRecord::Migration
  def change
    add_column :pages, :lang, :string
  end
end
