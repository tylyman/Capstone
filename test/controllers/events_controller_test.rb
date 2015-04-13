require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  def setup
    @event = events(:one)
    @user = users(:one)
    sign_in @user
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    post :create, event: {title: 'Simple Title'}
    assert_redirected_to assigns(:event)
  end

  test "should get update" do
    put :update, id: @event.id, event: {title: 'Title updated'}
    @event.reload
    assert_redirected_to @event
    assert_equal  'Title updated', @event.title
  end

  test "should get edit" do
    @event.users << users(:one)
    get :edit, id: @event.id
    assert_response :success
  end

  test "should destroy event" do
    @event.users << users(:one)
    delete :destroy, id: @event.id
    assert_redirected_to @event
  end

  test "should get show" do
    get :show, id: @event.id
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
