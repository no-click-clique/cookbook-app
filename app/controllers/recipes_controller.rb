class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
    render "index.html.erb"
  end

  def show
    @recipe = Recipe.find(params[:id])
    render "show.html.erb"
  end

end
