require 'test_helper'

module ContentManager
  class ContentTest < ActiveSupport::TestCase

    test 'data shuld be acessible as a hash' do
      test_value = "something"
      content = Content.new
      content.data[:test] = test_value
      assert_equal content.data[:test], test_value
    end
  end
end
