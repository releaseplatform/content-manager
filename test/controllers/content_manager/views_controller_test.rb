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
  end
end
