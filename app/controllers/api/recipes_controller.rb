class Api::RecipesController < ApplicationController

  def one_recipe_action
    render "one_recipe.json.jb"
  end

end
