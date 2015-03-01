Rails.application.routes.draw do
  resources :posts

  get 'activities/index'
  get 'feed' => 'feed#index'

  resources :comments,  :deals, :activities, :posts
  resources :followships, only: [:create, :show, :index]
	delete 'followships/unfollow', :to => 'followships#destroy'

	resources :loves, only: [:create, :show, :index]
	delete 'loves/unlove', :to => 'loves#destroy'

	devise_for :users, module: 'users'
	devise_for :businesses, module: 'businesses'
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

		  resources :loves, only: [:create, :show, :index]
			delete 'loves/unlove', :to => 'loves#destroy'
		end
	end
	
	root 'home#index'
end
