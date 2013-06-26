Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  resources :flash_sales, only: [:show]

  namespace :admin do
    resources :flash_sales do
      collection do
        get :saleables
      end
    end
  end
end
