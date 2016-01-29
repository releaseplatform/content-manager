require 'test_helper'

module ContentManager
  class ContentBaseTest < ActiveSupport::TestCase

    setup do
      TestContent = Class.new ContentBase
    end

    teardown do
      remove_const :test_content
    end

    test 'derive view name from subclass' do
      assert_equal TestContent.view_name, 'test'
    end

    test 'when included a view record is created' do
      assert_difference 'ContentManager::View.count' do
        Class.new ContentBase
      end
    end

    test 'calling content_key on class adds key to content_keys' do
      assert_difference  'TestContent.content_keys.length' do
        TestContent.content_key :test_key
      end
    end
  end
end
