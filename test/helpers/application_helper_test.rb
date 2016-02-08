module ContentManager
  class ApplicationHelperTest < ActionView::TestCase

    setup do
      class ::TestContent < ContentManager::ContentBase
        content_key :test, default: 'false'
      end
      class ::AnotherTestContent < ContentManager::ContentBase
        content_key :test, default: 'test'
      end
    end

    teardown do
      Object.send(:remove_const, :TestContent)
      Object.send(:remove_const, :AnotherTestContent)
    end

    test 'should provide content_view method for scoping cm calls' do
      # need an intuative way to test that the block was called
      test_value = ''
      content_view :another_test_content do
        test_value = cm(:test)
      end
      assert_equal 'test', test_value
      assert_equal 'false', cm(:test)
    end

  end
end
