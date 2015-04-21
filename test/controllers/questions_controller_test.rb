require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @question = questions(:one)
    sign_in @user
  end

  test "should get new" do
    get :new, user_id: @user.id
    assert_response :success
  end

  test "should create question" do
    assert_difference('Question.count', 1) do
      post :create, question: { :title => 'Test', :content => 'Test description', :user_id => 1, :category => 'General'}
    end
    question = assigns(:question)
    assert_response :success
  end
end
