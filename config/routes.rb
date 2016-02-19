Spree::Core::Engine.add_routes do
  namespace :admin, path: Spree.admin_path do
    get '/search/stores', to: "search#stores", as: :search_stores

    resources :stores
  end
end
