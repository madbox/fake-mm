require 'test_helper'

class AssigmentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assigments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assigment" do
    assert_difference('Assigment.count') do
      post :create, :assigment => { }
    end

    assert_redirected_to assigment_path(assigns(:assigment))
  end

  test "should show assigment" do
    get :show, :id => assigments(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => assigments(:one).to_param
    assert_response :success
  end

  test "should update assigment" do
    put :update, :id => assigments(:one).to_param, :assigment => { }
    assert_redirected_to assigment_path(assigns(:assigment))
  end

  test "should destroy assigment" do
    assert_difference('Assigment.count', -1) do
      delete :destroy, :id => assigments(:one).to_param
    end

    assert_redirected_to assigments_path
  end
end
