Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :product_categories, only: [:index, :new, :create, :edit, :update] do
    member do
      patch :deactivate
      patch :reactivate
    end
  end

  resources :products, only: [:new, :create, :show, :index, :edit, :update]

  resources :promotional_campaigns, only: [:index, :new, :create, :show, :edit, :update] do
    resources :campaign_categories, only:  [:create, :destroy]
  end

  resources :customer_areas, only: [:index]
  get "me", to: "customer_areas#me"
  post "update_phone_number", to: "users#update_phone"
end
