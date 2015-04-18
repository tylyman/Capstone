class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @transactions = User.Transaction.all
  end

  def index
    @users = User.all
  end
end
