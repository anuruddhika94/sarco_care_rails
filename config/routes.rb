Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      post "auth/signup", to: "auth#signup"
      post "auth/login", to: "auth#login"

      resource :me, only: [:show, :update], controller: :me

      resources :care_links, only: [:index, :create, :update] do
        collection { get :lookup }
      end

      resources :health_readings, only: [:index, :create]
      resources :assessments, only: [:index, :create]

      resource :meal_plan, only: [:show], controller: :meal_plans
      resources :meal_logs, only: [:index, :create]

      resources :exercises, only: [:index]
      resources :exercise_logs, only: [:index, :create]

      resources :articles, only: [:index, :show]
      resources :reminders, only: [:index, :update]

      resources :daily_goals, only: [:index]
    end
  end
end
