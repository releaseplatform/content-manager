ContentManager::Engine.routes.draw do
  resources :views, only: [:index, :show, :edit, :update] do
    resources :contents
  end
end
