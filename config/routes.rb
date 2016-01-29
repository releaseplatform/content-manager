ContentManager::Engine.routes.draw do
  controller :view do
    get '/' => :index
    get '/:id' => :show
    get '/:id/edit' => :edit
  end
end
