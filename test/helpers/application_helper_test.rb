module ContentManager
  class ApplicationHelperTest < ActionView::TestCase

    setup do
      class ::TestContent < ContentManager::ContentBase
        content_key :test, default: 'test'
      end
    end

    teardown do
      Object.send(:remove_const, :TestContent)
    end

    test 'should provide content_view method for scoping cm calls' do
      # need an intuative way to test that the block was called
      test_value = ''
      content_view :test_content do
        test_value = cm(:test)
      end
      assert_equal test_value, 'test'
    end

  end
end
