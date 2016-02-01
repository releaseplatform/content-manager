module ContentManager
  class ApplicationController < ::ApplicationController
    # auth the controllers unless no auth is provided
    before_action ContentManager.admin_auth_method unless ContentManager.admin_auth_method.nil?
  end
end
