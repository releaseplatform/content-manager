require_dependency "content_manager/application_controller"

module ContentManager
  class ViewController < ApplicationController
    def index
      @views = View.all
    end

    def show
      @view = View.find(params[:id])
    end

    def edit
      @view = View.find(params[:id])
    end
  end
end
