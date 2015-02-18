Rails.application.routes.draw do
  resources :posts

  get 'activities/index'

  resources :comments,  :deals, :activities, :followships, :posts

	devise_for :users
	devise_for :businesses
	resources :businesses do
		resources :avatars, only: [:create, :destroy]
	end
	resources :users do
		resources :avatars, only: [:create, :destroy]
	end

	namespace :api, path: '/', constraints: { subdomain: 'api' }, defaults: { format: :json } do
		namespace :v1 do
			devise_for :users, module: 'api/v1/users' 
			resources :users do 
				resources :avatars, only: [:create, :destroy]
			end
			devise_for :businesses, module: 'api/v1/businesses' 
			resources :businesses do
				resources :avatars, only: [:create, :destroy]
			end
			resources :deals, :activities, :users, :posts
			resources :followships, only: [:create, :show, :index]
		  delete 'followships/unfollow', :to => 'followships#destroy'
		end
	end
	
	root 'home#index'
end
