require_dependency "content_manager/application_controller"

module ContentManager
  class ContentsController < ApplicationController
    before_action :current_view
    before_action :current_content, only: [:show, :destroy, :edit, :update]

    def index
      @contents = current_view.contents
    end

    def show
    end

    def new
      @content = current_view.contents.new()
    end

    def create
      @content = current_view.contents.new(content_params)
      if @content.save
        redirect_to view_contents_path(current_view)
      else
        redirect_to :new, notice: "Content creation failed!"
      end
    end

    def destroy
      @content.destroy
      redirect_to view_contents_path(current_view)
    end

    def edit
    end

    def update
      if current_content.update(content_params)
        redirect_to view_content_path(current_view, current_content)
      else
        redirect_to edit_view_content_path(current_view, current_content), notice: "Failed to update Content"
      end
    end

    private

    def current_content
      @content ||= current_view.contents.find(params[:id])
    end

    def current_view
      @view ||= View.find(params[:view_id])
    end

    def content_params
      params.require(:content).permit(:version, data: current_view.to_constant.content_keys)
    end
  end
end
