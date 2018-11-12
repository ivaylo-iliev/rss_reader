Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'

  get 'news/index'
  get 'feeds/generate'
	post 'feeds/create'
	post 'feeds/new'
  resources :feeds do
    member do
      resources :entries, only: [:index, :show]
    end
  end
  root 'news#index'
end
