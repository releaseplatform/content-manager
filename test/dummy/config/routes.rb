Rails.application.routes.draw do

  mount ContentManager::Engine => "/content_manager"
end
