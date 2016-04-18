module ContentManager
  class Engine < ::Rails::Engine
    isolate_namespace ContentManager
    require 'jquery-rails'
  end
end
