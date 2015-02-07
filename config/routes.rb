Rails.application.routes.draw do
  resources :posts

  get 'activities/index'

  resources :comments,  :deals, :activities, :followships, :posts

	devise_for :users
	devise_for :businesses
	resources :businesses do
		resources :profile_pics, only: [:create, :destroy]
	end
	resources :users do
		resources :profile_pics, only: [:create, :destroy]
	end

	namespace :api, path: '/', constraints: { subdomain: 'api' } do
		namespace :v1 do
			devise_for :users, module: 'api/v1/users' 
			resources :users do 
				resources :profile_pics, only: [:create, :destroy]
			end
			devise_for :businesses, module: 'api/v1/businesses' 
			resources :businesses do
				resources :profile_pics, only: [:create, :destroy]
			end
			resources :deals, :activities, :users, :followships, :posts
		end
	end
	
	root 'home#index'
end
