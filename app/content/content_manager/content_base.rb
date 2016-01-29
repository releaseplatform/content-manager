module ContentManager
  class ContentBase
    def self.inherited(base)
      View.create!(name: view_name)
    end

    def self.view_name
      name.gsub(/Content$/, '').split('::').last.downcase
    end

    def self.content_keys
      @content_keys ||= []
    end

    def self.content_key(key)
      content_keys << key
    end
  end
end
