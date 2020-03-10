require 'rails_helper'

RSpec.describe "Recipes", type: :request do

  before do
    user = User.create(name: "Dani", email: "dani@gmail.com", password: "password")
    Recipe.create(title: "Example Title 1", ingredients: "Example Ingredients 1", directions: "Example Directions 1", image_url: "Example Image 1", prep_time: 30, user_id: user.id)
    Recipe.create(title: "Example Title 2", ingredients: "Example Ingredients 2", directions: "Example Directions 2", image_url: "Example Image 2", prep_time: 30, user_id: user.id)
    Recipe.create(title: "Example Title 3", ingredients: "Example Ingredients 3", directions: "Example Directions 3", image_url: "Example Image 3", prep_time: 30, user_id: user.id)
  end

  describe "GET /recipes" do
    it "returns an array of recipe hashes" do
      get "/api/recipes"
      expect(response).to have_http_status(200)
      recipes = JSON.parse(response.body)
      expect(recipes.length).to eq(3)
    end
  end

  describe "GET /recipes/:id" do
    it 'should return a hash with the appropriate recipe attributes' do
      get "/api/recipes/#{Recipe.first.id}"
      recipe = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(recipe["title"]).to eq("Example Title 1")
      expect(recipe["prep_time"]).to eq(30)
    end
  end

  describe "POST /recipes" do
    it 'should create a new recipe' do
      jwt = JWT.encode({user_id: User.first.id}, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      post "/api/recipes", params: {
        title: "New Recipe",
        ingredients: "New Ingredients",
        directions: "New Directions",
        prep_time: 30,
        image_url: "New Image Url"
      }, headers: { "Authorization" => "Bearer #{jwt}" }
      recipe = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(recipe["title"]).to eq("New Recipe")
    end
    it 'should return an error status code with invalid data' do
      jwt = JWT.encode({user_id: User.first.id}, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      post "/api/recipes", params: {}, headers: { "Authorization" => "Bearer #{jwt}" }
      recipe = JSON.parse(response.body)
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it 'should return an error status code with no jwt' do
      post "/api/recipes", params: {}
      recipe = JSON.parse(response.body)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "PATCH /recipes/:id" do
    it 'should update a recipe' do
      jwt = JWT.encode({user_id: User.first.id}, Rails.application.credentials.fetch(:secret_key_base), "HS256")

      patch "/api/recipes/#{Recipe.first.id}", 
      params: { title: "New Title" },
      headers: { "Authorization" => "Bearer #{jwt}" }

      recipe = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(recipe["title"]).to eq("New Title")
    end
    it 'should return 422 with bad data' do
      jwt = JWT.encode({user_id: User.first.id}, Rails.application.credentials.fetch(:secret_key_base), "HS256")

      patch "/api/recipes/#{Recipe.first.id}", 
      params: { title: "" },
      headers: { "Authorization" => "Bearer #{jwt}" }

      recipe = JSON.parse(response.body)
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it 'should return an error status code with no jwt' do
      patch "/api/recipes/#{Recipe.first.id}", params: {}
      recipe = JSON.parse(response.body)
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "DELETE /recipes/:id" do
    it "should delete a recipe" do
      jwt = JWT.encode({user_id: User.first.id}, Rails.application.credentials.fetch(:secret_key_base), "HS256")
      delete "/api/recipes/#{Recipe.first.id}", 
      headers: { "Authorization" => "Bearer #{jwt}" }

      expect(response).to have_http_status(200)
      expect(Recipe.count).to eq(2)
    end
    it "should delete a recipe" do
      delete "/api/recipes/#{Recipe.first.id}"

      expect(response).to have_http_status(:unauthorized)
      expect(Recipe.count).to eq(2)
    end
  end
end
