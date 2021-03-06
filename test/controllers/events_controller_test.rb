require 'test_helper'

class EventsControllerTest < ActionController::TestCase

  def setup
    @event = events(:one)
    @other_event = events(:two)
    @user = users(:one)
    sign_in @user
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event for logged in user" do
    post :create, event: {title: 'Simple Title'}
    event_created = assigns(:event)
    assert_equal event_created.owner, @user
  end

  test "should get update" do
    put :update, id: @event.id, event: {title: 'Title updated'}
    @event.reload
    assert_redirected_to events_path
    assert_equal  'Title updated', @event.title
  end

  test "should get edit" do
    @event.users << users(:one)
    get :edit, id: @event.id
    assert_response :success
  end

  test "should destroy event when user is owner" do
    @event.owner = users(:one)
    @event.save
    delete :destroy, id: @event.id
    assert_redirected_to events_path
  end

  test "should not destroy event when not the owner" do
    @event.users << users(:one)
    delete :destroy, id: @event.id
    assert_redirected_to @event
  end

  test "should get show" do
    @event.events_owner_id = @user.id
    @event.save
    get :show, id: @event.id
    assert_response :success
  end

  test "admin can view index" do
    @user.admin ='true'
    @user.save
    @event.events_owner_id = @user.id
    @event.save
    get :index
    assert_response :success
  end

  test "user cannot view index" do
    get :index
    assert_redirected_to root_path
  end

  test "Should enroll the user to the event" do
    @second_user = users(:two)
    sign_in @second_user
    @event.owner = @user
    @event.save
    put :enroll, {id: @event}
    assert_redirected_to root_path
    assert @event.total_spots - 1, @event.spots_left
    @event.reload
    assert_includes @event.users, @second_user
  end

  test "Should not enroll the owner to its own event" do
    @event.owner = @user
    @event.save
    put :enroll, {id: @event}
    assert_redirected_to root_path
    # assert the flash says, you can't add yourself as a participant
    @event.reload
    @event.valid?
  end
end
