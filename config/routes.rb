AccessLintHosted::Application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, only: [:create] do
    resource(
      :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
    )
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"

  root "home#show"

  get "/results", to: "results#index", as: :results

  get "/contact", to: "contact#index", as: :contact
  post "/contact", to: "contact#create"
end
