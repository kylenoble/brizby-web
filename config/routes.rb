Rails.application.routes.draw do
	devise_for :users, :skip => [:sessions, :passwords, :registrations]
	devise_for :businesses, :skip => [:sessions, :passwords, :registrations]

	namespace :api do
		namespace :v1 do
			devise_for :users, module: 'api/v1/users'
			devise_for :businesses, module: 'api/v1/businesses'
			resources :deals
		end
	end
	
	root 'home#index'
end
