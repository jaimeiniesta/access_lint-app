AccessLintHosted::Application.routes.draw do
  root "home#show"

  get "/results", to: "results#index", as: :results
end
