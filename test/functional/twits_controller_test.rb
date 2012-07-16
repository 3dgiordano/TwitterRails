require 'test_helper'

class TwitsControllerTest < ActionController::TestCase
  setup do
    @twit = twits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:twits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create twit" do
    assert_difference('Twit.count') do
      post :create, twit: { id: @twit.id }
    end

    assert_redirected_to twit_path(assigns(:twit))
  end

  test "should show twit" do
    get :show, id: @twit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @twit
    assert_response :success
  end

  test "should update twit" do
    put :update, id: @twit, twit: { id: @twit.id }
    assert_redirected_to twit_path(assigns(:twit))
  end

  test "should destroy twit" do
    assert_difference('Twit.count', -1) do
      delete :destroy, id: @twit
    end

    assert_redirected_to twits_path
  end
end
