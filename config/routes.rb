AccessLintHosted::Application.routes.draw do
  root "home#show"

  get "/results", to: "results#index", as: :results
  resource :results_email, only: [:new, :create]
end
