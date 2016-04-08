ContentManager::Engine.routes.draw do
  root 'views#index'

  resources :views, only: [:index, :show, :edit, :update] do
    resources :contents
  end
end
