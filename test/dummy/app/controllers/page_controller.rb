class PageController < ApplicationController
  include ContentManager::Controller

  def index
    render current_view.active_template
  end
end
