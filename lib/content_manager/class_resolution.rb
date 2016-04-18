module ContentManager
  module ClassResolution

    def self.content_class(name)
      begin
        content_class_name(name).constantize
      rescue NameError
        raise "Couldn't find constant definition #{name}, it should be in a file called #{name}.rb"
      end
    end

    def self.content_class_name(class_name)
      klass = class_name.classify

      if Object.const_defined?(klass)
        return klass
      elsif file_path = rails_constant_file_path(class_name)
        require file_path
        return klass
      else
        return "content_manager/#{class_name}".classify
      end
    end

    def self.rails_constant_file_path(class_name)
      Dir["#{Rails.root}/{app,lib}/**/#{class_name}.rb"].first
    end
  end
end
