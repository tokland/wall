require 'test_helper'

class LiveClassesControllerTest < ActionController::TestCase
  setup do
    @live_class = live_classes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:live_classes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create live_class" do
    assert_difference('LiveClass.count') do
      post :create, :live_class => @live_class.attributes
    end

    assert_redirected_to live_class_path(assigns(:live_class))
  end

  test "should show live_class" do
    get :show, :id => @live_class.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @live_class.to_param
    assert_response :success
  end

  test "should update live_class" do
    put :update, :id => @live_class.to_param, :live_class => @live_class.attributes
    assert_redirected_to live_class_path(assigns(:live_class))
  end

  test "should destroy live_class" do
    assert_difference('LiveClass.count', -1) do
      delete :destroy, :id => @live_class.to_param
    end

    assert_redirected_to live_classes_path
  end
end
