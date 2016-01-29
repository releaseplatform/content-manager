module ContentManager
  class View < ActiveRecord::Base
    has_many :contents
  end
end
