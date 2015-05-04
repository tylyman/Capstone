require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @other_user = users(:two)
    @question = questions(:one)
    sign_in @user
  end

  test "gets new question" do
    get :new, user_id: @user.id
    assert_response :success
  end

  test "shows question" do
    post :create, question: { :title => 'Test', :content => 'Test description', :user_id => 1, :category => 'General'}
    question = assigns(:question)
    get :show, id: question.id
    assert_response :success
  end

  test "shows index" do
    get :index
    assert_response :success
  end

  test "creates question" do
    assert_difference('Question.count', 1) do
      post :create, question: { :title => 'Test', :content => 'Test description', :user_id => 1, :category => 'General'}
    end
    question = assigns(:question)
    assert_response :success
  end

  test "question title can't contain profanity" do
    assert_difference('Question.count', 0) do
      post :create, question: { :title => 'Crap', :content => 'Test description', :user_id => 1, :category => 'General'}
    end
  end

  test "question content can't contain profanity" do
    assert_difference('Question.count', 0) do
      post :create, question: { :title => 'Test', :content => 'Shit', :user_id => 1, :category => 'General'}
    end
  end

  test "edits question" do
    get :edit, id: @question.id
    assert_response :success
    assert_template :edit
    patch :update, id: @question.id, question: { :title => "Updated"}
    question = assigns(:question)
    assert_equal question.title, "Updated"
  end

  test "only owner can edit question" do
    sign_out @user
    sign_in @other_user
    get :edit, id: @question.id
    patch :update, id: @question.id, question: { :title => "Updated"}
    question = assigns(:question)
    assert_not_equal question.title, "Updated"
  end

  test "owner deletes question" do
    post :create, question: { :title => 'Test', :content => 'Test description', :user_id => 1, :category => 'General'}
    question = assigns(:question) 
    assert_difference('Question.count', -1) do
      get :destroy, id: question.id
    end
    assert_redirected_to questions_path
  end

  test "only owner can delete question" do 
    post :create, question: { :title => 'Test', :content => 'Test description', :user_id => 1, :category => 'General'}
    sign_out @user
    sign_in @other_user
    question = assigns(:question) 
    assert_no_difference('Question.count') do
      get :destroy, id: question.id
    end
  end
end
