module ContentManager
  class View < ActiveRecord::Base
    has_many :contents

    def to_constant
      constant_name.classify.constantize
    end
  end
end
