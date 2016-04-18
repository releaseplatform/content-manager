require 'test_helper'

module ContentManager
  class ViewsControllerTest < ActionController::TestCase
    setup do
      @routes = Engine.routes
      ContentManager.show_internal_content = true
    end

    test 'all view should be available on index' do
      get :index
      assert_equal assigns(:views), views()
    end

    test 'view is available on edit' do
      get :edit, id: views(:one)
      assert_equal assigns(:view), views(:one)
    end

    test 'update view active_template' do
      view = views(:one)

      # updte redirects to :back, should probably chance this
      request.env["HTTP_REFERER"] = '/contents/index'
      post :update, id: view, view: { active_template: 'test' }

      assert_equal 'test', view.reload.active_template
    end
  end
end
