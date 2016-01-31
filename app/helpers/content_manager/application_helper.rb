module ContentManager
  module ApplicationHelper
    # a helper to automatically figure out where to get you're content from
    def cm(key)
      content_instance.public_send(key.to_sym)
    end

    private

    def content_instance
      #TODO:  defaults to verrsion 0, need to allow specifying default
      @content_instance = content_class.new(version: 0)
    end

    # TODO: This is hard, even rails does it wrong, need a better solution
    def content_class
      # ensure constant is loaded
      if file_path = constant_file_path
        require_dependency file_path
        constant_name.classify.constantize
      else
        begin
          return "content_manager/#{constant_name}".classify.constantize
        rescue NameError
          raise "Couldn't find constant definition #{constant_name}, it should be in a file called #{constant_name}.rb"
        end
      end
    end

    def constant_file_path
      Dir["#{Rails.root}/**/#{constant_name}.rb"].first
    end

    # the default for constants will be ControllerActionContent
    def constant_name
      "#{controller.controller_name}_#{controller.action_name}_content"
    end
  end
end
