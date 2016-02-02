require "content_manager/engine"

module ContentManager
  # This is a method on the ::ApplicationController that will check if
  # the current user is authorized to edit the content
  mattr_accessor :admin_auth_method
  
  # Should the internal content presenters be displayed in the admin view?
  mattr_accessor :show_internal_content

  def self.configure(&block)
    yield self unless block.nil? 
  end
end
