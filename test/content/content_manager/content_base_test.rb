require 'test_helper'

module ContentManager
  class ContentBaseTest < ActiveSupport::TestCase

    setup do
      class TestContent < ContentBase; end
    end

    teardown do
      delete_constant(:TestContent)
    end

    def delete_constant(symbol)
      ContentBaseTest.send(:remove_const, symbol.to_sym)
    end

    test 'when inherited a view record is created' do
      assert_difference 'ContentManager::View.count' do
        class AnotherTestContent < ContentBase; end
      end
    end

    test 'if a view record exists it is used' do
      assert_no_difference 'ContentManager::View.count' do
        delete_constant(:TestContent)
        class TestContent < ContentBase; end
      end
    end

    test 'calling content_key on class adds key to content_keys' do
      assert_difference  'TestContent.content_keys.length' do
        TestContent.content_key :test_key
      end
    end

    test 'content.<key> on instance returns stored value at <key>' do
      test_value = "this is a test"
      TestContent.class_eval { content_key :test }
      content = TestContent.new(version: 0)
      Content.create!(version: 0, data: { test: test_value },
                      view: content.current_view)
      assert_equal content.test, test_value
    end

    test 'no exception raised if when calling key if default supplied' do
      TestContent.class_eval { content_key :test, default: "test" }

      content = TestContent.new(version: 0)
      content.test
    end

    test 'when name is set in class, view model is saved with name provided' do
      # can't use local variable because of weird ruby class evaulation issues?
      class NewTestContent < ContentBase
        content_alias 'LandingPage'
      end

      assert_equal NewTestContent.current_view.name, 'LandingPage'
    end

    test 'provide a list of templates for a View Presenter (Content) and access them at run time' do
      test_templates = ['landing_page1', 'landing_page2']

      class TemplateTestContent < ContentBase
        view_templates ['landing_page1', 'landing_page2']
      end

      assert_equal test_templates, TemplateTestContent.available_templates
    end

    test 'active template defaults to the first template available' do
      active_template = 'landing_page1'

      class TemplateTestContent < ContentBase
        view_templates ['landing_page1', 'landing_page2']
      end

      assert_equal active_template, TemplateTestContent.active_template
    end
  end
end
