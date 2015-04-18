require 'test_helper'

class AnswersControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @answer = answers(:one)
    @question = questions(:one)
    sign_in @user
  end

  test "should get new" do
    get :new, question_id: @question.id
    assert_response :success
  end

  test "should post create" do
    post :create, question_id: @question.id, answer: { :content => 'Test' }
    answer = assigns(:answer)
    assert answer.content, "Test"
    assert_response :success
  end

  test "should put update" do
    put :update, id: @answer.id, answer: {content: 'Content updated'}, question_id: @question.id
    @answer.reload
    assert_redirected_to @question
    assert_equal  'Content updated', @answer.content
  end

  test "should get edit" do
    xhr :get, :edit, id: @answer.id, question_id: @question.id
    put :update, id: @answer.id, answer: {content: 'Content updated'}, question_id: @question.id
    @answer.reload
    assert_redirected_to @question
    assert_equal  'Content updated', @answer.content
  end

  test "should destroy answer" do
    delete :destroy, id: @answer.id, question_id: @question.id
    assert_redirected_to @question
  end

  test "should get show" do
    get :show, id: @answer.id, question_id: @question.id
    assert_response :success
  end

end
