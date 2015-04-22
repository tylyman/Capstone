require 'test_helper'

class AnswersControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @other_user = users(:two)
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
    assert_response :success
    assert_equal  'Content updated', @answer.content
  end

  test "can edit" do
    xhr :get, :edit, id: @answer.id, question_id: @question.id
    put :update, id: @answer.id, answer: {content: 'Content updated'}, question_id: @question.id
    @answer.reload
    assert_response :success
    assert_equal  'Content updated', @answer.content
  end

  test "only owner can edit" do
    sign_out @user
    sign_in @other_user
    xhr :get, :edit, id: @answer.id, question_id: @question.id
    put :update, id: @answer.id, answer: {content: 'Updated'}, question_id: @question.id
    @answer.reload
    assert_equal 'Test1', @answer.content
  end

  test "can delete answer" do
    delete :destroy, id: @answer.id, question_id: @question.id
  end

  test "only owner can delete answer" do
    sign_out @user
    sign_in  @other_user
    assert_no_difference('@question.answers.count') do
      delete :destroy, id: @answer.id, question_id: @question.id
    end
  end

  test "should get show" do
    get :show, id: @answer.id, question_id: @question.id
    assert_response :success
  end

  test "can up vote" do
    before = @answer.helpful
    get :vote, :id => @answer.id, :vote => 'up'
    @answer = assigns(:answer)
    after = @answer.helpful
    assert_equal before +1, after
    assert_redirected_to @answer.question
  end

  test "can down vote" do
    before = @answer.helpful
    get :vote, :id => @answer.id, :vote => 'down'
    @answer = assigns(:answer)
    after = @answer.helpful
    assert_equal before -1, after
    assert_redirected_to @answer.question
  end

  test "cannot vote more than once" do 
    before = @answer.helpful
    get :vote, :id => @answer.id, :vote => 'down'
    @answer = assigns(:answer)
    after = @answer.helpful
    assert_equal before -1, after
    assert_redirected_to @answer.question

    second_before = @answer.helpful
    get :vote, :id => @answer.id, :vote => 'down'
    @answer = assigns(:answer)
    second_after = @answer.helpful
    assert_equal second_before, second_after
    assert_redirected_to @answer.question

    before = @answer.helpful
    get :vote, :id => @answer.id, :vote => 'up'
    @answer = assigns(:answer)
    after = @answer.helpful
    assert_equal before, after
    assert_redirected_to @answer.question
  end
end
