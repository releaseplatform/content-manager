require 'test_helper'

module ContentManager
  class ViewControllerTest < ActionController::TestCase
    setup do
      @routes = Engine.routes
    end

    test 'all view should be available on index' do
      get :index
      assert_equal assigns(:views), views()
    end

    test 'view is available on edit' do
      get :edit, id: views(:one)
      assert_equal assigns(:view), views(:one)
    end

    def views(sym=nil)
      if sym
        return content_manager_views(sym.to_sym)
      else
        View.all
      end
    end
  end
end
