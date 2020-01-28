class RemoveChefFromRecipes < ActiveRecord::Migration[6.0]
  def change

    remove_column :recipes, :chef, :string
  end
end
