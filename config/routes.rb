AccessLintHosted::Application.routes.draw do
  get 'home/show'
  post 'audit', to: 'home#audit'
  root 'home#show'
end
