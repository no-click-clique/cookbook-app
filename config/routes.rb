Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  get "/recipes" => "recipes#index"
  get "/recipes/new" => "recipes#new"
  get "/recipes/:id" => "recipes#show"
  post "/recipes" => "recipes#create"
  get "/recipes/:id/edit" => "recipes#edit"
  patch "/recipes/:id" => "recipes#update"
  delete "/recipes/:id" => "recipes#destroy"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  namespace :api do
    get "/recipes" => "recipes#index"
    post "/recipes" => "recipes#create"
    get "/recipes/:id" => "recipes#show"
    patch "/recipes/:id" => "recipes#update"
    delete "/recipes/:id" => "recipes#destroy"

    post "/users" => "users#create"
    get "/users/:id" => "users#show"
    post "/sessions" => "sessions#create"

    get "/messages" => "messages#index"
    post "/messages" => "messages#create"
  end

  get "/*path" => proc { [200, {}, [ActionView::Base.new.render(file: 'public/index.html')]] }
end
