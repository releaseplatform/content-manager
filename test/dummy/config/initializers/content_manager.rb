ContentManager.configure do |config|
  config.admin_auth_method = :authenticate_user!
  config.show_internal_content = true
end
