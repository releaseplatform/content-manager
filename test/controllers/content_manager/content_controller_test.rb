require 'test_helper'

module ContentManager
  class ContentControllerTest < ActionController::TestCase
    setup do
      @routes = Engine.routes
    end

    test 'should have content version available for view' do
      view = views(:two)
      get :show, view_id: view.id, id: view.contents.first.id
      assert_equal assigns(:content), view.contents.first
      assert_equal assigns(:view), view
    end

    test 'should display form for creating new content version' do
      class ContentTest < ContentBase; end
      get :new, view_id: ContentTest.current_view.id
      assigns(:content)
    end

    test 'should create new content version' do
      assert_difference 'ContentManager::Content.count' do
        post :create, view_id: views(:two).id, content: { version: 0 }
      end
    end
  end
end
