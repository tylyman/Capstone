require 'test_helper'

class AnswersControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @answer = answers(:one)
    @question = questions(:one)
    sign_in @user
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    post :create, answer: {title: 'Simple Title'}
    assert_redirected_to assigns(:answer)
  end

  test "should get update" do
    put :update, id: @answer.id, asnwer: {title: 'Title updated'}
    @answer.reload
    assert_redirected_to @answer
    assert_equal  'Title updated', @answer.title
  end

  test "should get edit" do
    @answer.users << users(:one)
    get :edit, id: @answer.id
    assert_response :success
  end

  test "should destroy answer" do
    @answer.users << users(:one)
    delete :destroy, id: @answer.id
    assert_redirected_to @answer
  end

  test "should get show" do
    get :show, id: @answer.id
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end
end
