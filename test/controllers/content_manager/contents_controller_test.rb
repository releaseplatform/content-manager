require 'test_helper'

module ContentManager
  class ContentsControllerTest < ActionController::TestCase
    setup do
      @routes = Engine.routes
      class TestContent < ContentBase; end
    end

    teardown do
      ContentsControllerTest.send(:remove_const, :TestContent)
    end

    test 'should have all convent for view on index' do
      get :index, view_id: TestContent.current_view.id
      assert_equal assigns(:contents), TestContent.current_view.contents
    end

    test 'should have content version available for view' do
      view = views(:two)
      get :show, view_id: view.id, id: view.contents.first.id
      assert_equal assigns(:content), view.contents.first
      assert_equal assigns(:view), view
    end

    test 'should display form for creating new content version' do
      get :new, view_id: TestContent.current_view.id
      assigns(:content)
    end

    test 'should create new content version' do
      assert_difference 'ContentManager::Content.count' do
        post :create, view_id: TestContent.current_view, content: { version: 0, data: { test: "this is a test" } }
      end
    end

    test 'should delete existing content' do
      assert_difference 'ContentManager::Content.count', -1 do
        delete :destroy, view_id: views(:two).id, id: views(:two).contents.first.id
      end
    end

    test 'should show edit with view assigned' do
      view = TestContent.current_view
      view.contents.create!
      get :edit, view_id: view.id, id: view.contents.first.id
      assert_equal assigns(:content), view.contents.first
    end

    test 'should update view content with data' do
      updated_text = "this is an upate" 
      view = TestContent.current_view
      view.contents.create!
      put :update, view_id: view.id, id: view.contents.first.id, content: { data: { test: updated_text } } 
      assert_equal view.contents.first.data['test'], updated_text
    end
  end
end
