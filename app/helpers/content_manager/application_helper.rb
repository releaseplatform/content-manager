module ContentManager
  module ApplicationHelper
    # a helper to automatically figure out where to get you're content from
    def cm(key)
      content_instance.public_send(key.to_sym)
    end

    def content_view(view_name, &block)
      # pretend to be a rails controller
      view = block.binding.eval('self')
      view.class.class_eval do
        define_method(:cm) { |key|
          content_instance(view_name.to_s).public_send(key.to_sym)
        }
      end
      block.call
    end

    private

    def content_instance(name=nil)
      #TODO:  defaults to verrsion 0, need to allow specifying default
      @content_instance = content_class(name).new(version: 0)
    end

    # TODO: This is hard, even rails does it wrong, need a better solution
    def content_class(name=nil)
      # ensure constant is loaded
      constant_class = (name || constant_name).classify
      if Object.const_defined?(constant_class)
        constant_class.constantize
      elsif file_path = constant_file_path(name)
        # This will not load class in module properly
        require_dependency file_path
        constant_class.constantize
      else
        begin
          return "content_manager/#{constant_name}".classify.constantize
        rescue NameError
          raise "Couldn't find constant definition #{constant_name}, it should be in a file called #{constant_name}.rb"
        end
      end
    end

    # needs to be limited to app and lib dir's because
    # Heroku puts gem content in vendor
    def constant_file_path(name=nil)
      Dir["#{Rails.root}/{app,lib}/**/#{name || constant_name}.rb"].first
    end

    # the default for constants will be ControllerActionContent
    def constant_name
      # extend the controller api, this could probably be simpler
      if controller.respond_to?(:content_name)
        controller.content_name
      else
        "#{controller.controller_name}_#{controller.action_name}_content"
      end
    end
  end
end
