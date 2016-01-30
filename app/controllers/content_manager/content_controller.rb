require_dependency "content_manager/application_controller"

module ContentManager
  class ContentController < ApplicationController
    before_action :current_view

    def show
      @content = @view.contents.find(params[:id])
    end

    def new
      @content = current_view.contents.new()
    end

    def create
      @content = current_view.contents.new(content_params)
      if @content.save
        redirect_to view_path(current_view)
      else
        redirect_to :new, notice: "Content creation failed!"
      end
    end

    private

    def current_view
      @view ||= View.find(params[:view_id])
    end

    def content_params
      params.require(:content).permit(:version, :data)
    end
  end
end
