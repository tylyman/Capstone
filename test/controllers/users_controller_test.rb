require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @transaction = transactions(:one)
    @event = events(:one)
    sign_in @user
  end
  test "should get show" do
    @user.events << @event
    get :show, id: @user.id
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "admin can view admin page" do
    @user.admin ='true'
    @user.save
    get :admin, :id => @user
    assert_response :success
  end

  test "non-admin cannot view admin page" do
    get :admin, :id => @user
    assert_redirected_to root_url
  end

  test "user can view edit admin page" do
    get :edit_admin, :id => @user
    assert_response :success
  end
end
