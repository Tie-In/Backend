require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users

  # Api definition
  namespace :api, defaults: { format: :json }, constraints: { }, path: '/api' do
    # We are going to list our resources here
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      # We are going to list our resources here
      resources :users, :only => [:index, :show, :create, :update ]
      resources :sessions, :only => [:create, :destroy]
      resources :organizations, :only => [:show, :create]
      resources :projects, :only => [:show, :create]
      # resources :features, :only => [:create]
      resources :effort_estimations, :only => [:show, :create]
      resources :tasks, :only => [:create]
      resources :tags, :only => [:index, :create]
    end
  end
end
