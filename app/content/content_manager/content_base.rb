module ContentManager
  class ContentBase
    def self.inherited(base)
      if base.respond_to? :name
        # inform user that inherited class cannot be anonymous
        View.find_or_create_by!({
          constant_name: base.name 
        })
      end
    end

    def self.content_keys
      @content_keys ||= []
    end

    def self.content_key(key, options={})
      content_keys << key
      define_method(key) do
        if content = current_view.contents.find_by(version: @version)
          content.data[key.to_s]
        elsif content = options[:default]
          content
        else
          raise "No value for view: #{current_view.name}, version: #{@version}, key: #{key}"
        end
      end
    end

    def self.content_alias(name)
      current_view.update(name: name.to_s)
    end

    def initialize(options)
      @version = options[:version]
    end

    def method_missing(name, *args, &block)
      raise "No value for view: #{current_view.name}, version: #{@version}, key: #{name}"
    end

    def self.current_view
      View.find_by!(constant_name: self.name)
    end
    
    def current_view
      @view ||= self.class.current_view
    end
  end
end
