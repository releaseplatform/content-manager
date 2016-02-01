require "content_manager/engine"

module ContentManager
  # This is a method on the ::ApplicationController that will check if
  # the current user is authorized to edit the content
  mattr_accessor :admin_auth_method
  def self.configure(&block)
    yield self unless block.nil? 
  end
end
