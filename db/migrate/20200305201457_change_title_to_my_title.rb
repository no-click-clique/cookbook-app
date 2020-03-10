class ChangeTitleToMyTitle < ActiveRecord::Migration[6.0]
  def change
    rename_column :recipes, :title, :my_title
  end
end
