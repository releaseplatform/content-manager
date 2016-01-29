module ContentManager
  class Content < ActiveRecord::Base
    belongs_to :view
  end
end
