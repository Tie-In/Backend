require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users

  # Api definition
  namespace :api, defaults: { format: :json }, constraints: { }, path: '/api' do
    # We are going to list our resources here
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      # We are going to list our resources here
      resources :users
      resources :user_organizations, :only => [:create, :update, :destroy]
      resources :project_contributes, :only => [:create, :update, :destroy]
      resources :sessions, :only => [:create, :destroy]
      resources :organizations
      resources :projects
      resources :sprints, :only => [:show, :create, :update]
      resources :effort_estimations, :only => [:show, :create]
      resources :tasks
      resources :tags
      resources :statuses
      resources :retrospectives, :only => [:create, :update, :show]
      resources :viewpoints
      resources :viewpoint_categories
    end
  end
end
