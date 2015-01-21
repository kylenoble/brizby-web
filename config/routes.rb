Rails.application.routes.draw do
  resources :comments

	devise_for :users, :skip => [:sessions, :passwords, :registrations]
	devise_for :businesses
	resources :businesses do
		resources :profile_pics, only: [:create, :destroy]
	end
	resources :deals

	namespace :api do
		namespace :v1 do
			devise_for :users, module: 'api/v1/users' 
			resources :users do 
				resources :profile_pics, only: [:create, :destroy]
			end
			devise_for :businesses, module: 'api/v1/businesses' 
			resources :businesses do
				resources :profile_pics, only: [:create, :destroy]
			end
			resources :deals
		end
	end
	
	root 'home#index'
end
