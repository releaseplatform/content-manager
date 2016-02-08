# Rubies SimpleDelegator doesn't seem to work
# for this usecase? TODO: Explore more.
class Proxy
  def initialize(delegate, &block)
    @delegate = delegate
    yield self unless block.nil?
  end
  def method_missing(op, *args, &block)
    @delegate.send(op, *args, &block) 
  end
end

module ContentManager
  module ApplicationHelper
    # a helper to automatically figure out where to get you're content from
    def cm(key)
      content_instance.public_send(key.to_sym)
    end

    def content_view(view_name, &block)
      # scope a block to a content view via a proxy view
      template = block.binding.eval('self')
      proxy = Proxy.new(template) do |proxy|
        proxy.define_singleton_method(:cm) do |key|
          content_instance(view_name.to_s).public_send(key.to_sym)
        end
      end
      # return a template
      template.concat(proxy.instance_eval(&block))
    end

    private

    def content_instance(name=nil)
      #TODO:  defaults to verrsion 0, need to allow specifying default
      @content_instance = content_class(name).new(version: 0)
    end

    # TODO: This is hard, even rails does it wrong, need a better solution
    def content_class(name=nil)
      # ensure constant is loaded
      name = name || constant_name
      constant_class = name.classify
      if Object.const_defined?(constant_class)
        constant_class.constantize
      elsif file_path = constant_file_path(name)
        # This will not load class in module properly
        require_dependency file_path
        constant_class.constantize
      else
        begin
          return "content_manager/#{name}".classify.constantize
        rescue NameError
          raise "Couldn't find constant definition #{name}, it should be in a file called #{name}.rb"
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
      "#{controller.controller_name}_#{controller.action_name}_content"
    end
  end
end
