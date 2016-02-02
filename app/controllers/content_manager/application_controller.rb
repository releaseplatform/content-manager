module ContentManager
  class ApplicationController < ::ApplicationController
    # Provide layout for all views unless none is given
    layout ContentManager.layout unless ContentManager.layout.nil?
    # auth the controllers unless no auth is provided
    before_action ContentManager.admin_auth_method unless ContentManager.admin_auth_method.nil?
  end
end
