require_dependency "content_manager/application_controller"

module ContentManager
  class ViewsController < ApplicationController
    def index
      # this is the ideal place for a presenter
      if ContentManager.show_internal_content
        @views = View.all
      else
        @views = View.where.not("constant_name LIKE 'ContentManager%'")
      end
    end

    def show
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
