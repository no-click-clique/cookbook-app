class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
    render "index.html.erb"
  end

  def show
    @recipe = Recipe.find(params[:id])
    render "show.html.erb"
  end

  def new
    render "new.html.erb"
  end

  def create
    @recipe = Recipe.new(
      title: params[:title],
      ingredients: params[:ingredients],
      directions: params[:directions],
      prep_time: params[:prep_time],
      image_url: params[:image_url],
      user_id: params[:user_id]
    )
    @recipe.save
    redirect_to "/recipes/#{@recipe.id}"
  end

  def edit
    @recipe = Recipe.find(params[:id])
    render "edit.html.erb"
  end

end
