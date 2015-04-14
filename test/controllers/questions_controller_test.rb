require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @question = questions(:one)
    sign_in @user
  end
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, id: @question.id
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end
end
