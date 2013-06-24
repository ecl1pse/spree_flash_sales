Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  resources :flash_sales, only: [:show]
end
