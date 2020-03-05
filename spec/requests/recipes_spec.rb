require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  describe "GET /recipes" do
    it "returns an array of recipe hashes" do
      user = User.create(name: "Dani", email: "dani@gmail.com", password: "password")
      Recipe.create(title: "Example Title 1", ingredients: "Example Ingredients 1", directions: "Example Directions 1", image_url: "Example Image 1", prep_time: 30, user_id: user.id)
      Recipe.create(title: "Example Title 2", ingredients: "Example Ingredients 2", directions: "Example Directions 2", image_url: "Example Image 2", prep_time: 30, user_id: user.id)
      Recipe.create(title: "Example Title 3", ingredients: "Example Ingredients 3", directions: "Example Directions 3", image_url: "Example Image 3", prep_time: 30, user_id: user.id)
      get "/api/recipes"
      expect(response).to have_http_status(200)
      recipes = JSON.parse(response.body)
      expect(recipes.length).to eq(3)
    end
  end

  describe "GET /recipes/:id" do
    it 'should return a hash with the appropriate recipe attributes' do
      user = User.create(name: "Dani", email: "dani@gmail.com", password: "password")
      recipe = Recipe.create(title: "Example Title 1", ingredients: "Example Ingredients 1", directions: "Example Directions 1", image_url: "Example Image 1", prep_time: 30, user_id: user.id)
      get "/api/recipes/#{recipe.id}"
      recipe = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(recipe["title"]).to eq("Example Title 1")
      expect(recipe["prep_time"]).to eq(30)
    end
  end
end
