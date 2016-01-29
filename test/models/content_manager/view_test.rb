require 'test_helper'

module ContentManager
  class ViewTest < ActiveSupport::TestCase
    test 'should have list of content' do
      assert_equal views(:two).contents, contents()
    end
  end
end
