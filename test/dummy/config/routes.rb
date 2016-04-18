Rails.application.routes.draw do
  root 'page#index'
  mount ContentManager::Engine => "/content_manager"
end
