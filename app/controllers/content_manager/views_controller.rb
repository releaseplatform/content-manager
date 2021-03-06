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
      @view.update_attributes(view_params)
      if @view.valid?
        @view.save
        redirect_to :back
      else
        redirect_to :back, alert: 'Invalid View'
      end
    end

    private

    def view_params
      params.require(:view).permit(:active_template)
    end
  end
end
