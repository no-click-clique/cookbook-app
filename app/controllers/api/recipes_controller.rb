class Api::RecipesController < ApplicationController

  def index
    @recipes = Recipe.all #array of recipe hashes
    render "index.json.jb"
  end

  def show
    @recipe = Recipe.find_by(id: params["id"])
    render "show.json.jb"
  end
  
end
