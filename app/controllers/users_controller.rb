class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @transactions = @user.transactions
  end

  # Edits the admin state of the user, not the user registration.
  def edit
  	@user = User.find(params[:id])

  end

  # Checks to see if the user is authorized to become an Admin.
  def update

  end

  # Admin portal.
  def admin
  	@user = User.find(params[:id])
  	@users = User.all

  	if !current_user.admin?
			flash[:danger] = "You are not authorized to view this page."
 	  	redirect_to root_url
		end
  end

  def index
    @users = User.all
  end
end
