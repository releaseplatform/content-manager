module ContentManager
  class Content < ActiveRecord::Base
    belongs_to :view
    serialize :data, JSON
  end
end
