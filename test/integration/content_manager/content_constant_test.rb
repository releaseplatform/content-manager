require 'test_helper'

module ContentManager
  class ContentConstantTest < ActiveSupport::TestCase
    setup do
      class TestContent < ContentBase
        content_key :test
      end
    end

    teardown do
      ContentConstantTest.send(:remove_const, :TestContent)      
    end

    test 'should be able to get constant from view record name' do
      assert_equal TestContent.current_view.to_constant, TestContent
    end

    test 'should have access to content_keys of view generate constant' do
      assert_equal TestContent.current_view.to_constant.content_keys, TestContent.content_keys
    end
  end
end
