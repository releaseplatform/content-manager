require_dependency "content_manager/application_controller"

module ContentManager
  class ViewController < ApplicationController
    def index
      @content = ViewIndexContent.new(version: 0)
      @views = View.all
    end

    def show
      @content = ViewShowContent.new(version: 0)
      @view = View.find(params[:id])
    end

    def edit
      @view = View.find(params[:id])
    end

    def update
      @view = View.find(params[:id])
    end
  end
end
