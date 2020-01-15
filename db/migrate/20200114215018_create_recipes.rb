class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :ingredients
      t.string :title
      t.string :directions
      t.integer :prep_time
      t.string :image_url
      t.string :chef

      t.timestamps
    end
  end
end
