ContentManager::Engine.routes.draw do
  resources :view, only: [:index, :show, :edit, :update] do
    resources :content
  end
end
