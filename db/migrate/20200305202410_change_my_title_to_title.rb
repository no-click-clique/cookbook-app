class ChangeMyTitleToTitle < ActiveRecord::Migration[6.0]
  def change
    rename_column :recipes, :my_title, :title
  end
end
