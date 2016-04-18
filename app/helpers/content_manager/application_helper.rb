# Rubies SimpleDelegator doesn't seem to work
# for this usecase? TODO: Explore more.
class Proxy
  def initialize(delegate, &block)
    @delegate = delegate
    yield self unless block.nil?
  end
  def method_missing(*args, &block)
    @delegate.send(*args, &block) 
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
        content = content_instance(view_name.to_s)

        template.instance_variables.each do |key|
          proxy.instance_variable_set(key, template.instance_variable_get(key))
        end
        proxy.define_singleton_method(:cm) do |key|
          content.public_send(key.to_sym)
        end
      end
      proxy.instance_eval(&block)
    end

    private

    def content_instance(name=nil)
      # Why not just use a function?
      content_class = ClassResolution.content_class(name || constant_name)

      #TODO:  defaults to verrsion 0, need to allow specifying default
      @content_instance = content_class.new(version: 0)
    end

    # the default for constants will be ControllerActionContent
    def constant_name
      # extend the controller api, this could probably be simpler
      "#{controller.controller_name}_#{controller.action_name}_content"
    end
  end
end
