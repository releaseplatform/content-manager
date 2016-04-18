module ContentManager
  module Controller
    def current_view
      View.find_or_create_by!({
        constant_name: view_content_constant_class_name
      })
    end

    def view_content_constant_class_name
      ClassResolution.content_class_name(view_content_constant_name)
    end

    def view_content_constant_name
      "#{self.controller_name}_#{self.action_name}_content"
    end
  end
end
