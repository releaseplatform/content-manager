def klass_name(klass)
  if klass.name
    klass.name
  else
    ''
  end
end

def de_modularize(name)
  if name.include? '::'
    name.split('::').last
  else
    name
  end
end

def view_name(klass)
  de_modularize(klass_name(klass)).gsub(/Content$/, '').downcase
end

module ContentManager
  class ContentBase
    def self.inherited(base)
      if base.respond_to? :name
        # inform user that inherited class cannot be anonymous
        View.find_or_create_by!({
          name: view_name(base),
          constant_name: base.name
        })
      end
    end

    def self.content_keys
      @content_keys ||= []
    end

    def self.content_key(key)
      content_keys << key
      define_method(key) do
        current_view.contents.find_by(version: @version).data[key.to_s]
      end
    end

    def initialize(options)
      @version = options[:version]
    end

    def self.current_view
      View.find_by_name(view_name(self))
    end
    
    def current_view
      @view ||= self.class.current_view
    end
  end
end
