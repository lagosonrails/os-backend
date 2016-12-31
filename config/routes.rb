Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  defaults format: 'json' do
    namespace :api do
      namespace :v1 do
        resources :addresses
        get :search, to: 'searches#search'
        # resource :search, controller: 'search'

        resources :companies do
          resources :addresses, on: :member
        end
      end
    end
  end
end
