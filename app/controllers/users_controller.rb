class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @transactions = @user.transactions
  end

  # Edits the admin state of the user, not the user registration.
  def edit_admin
  	@user = User.find(params[:id])
  end

  # Checks to see if the user is authorized to become an Admin and updates user admin column.
  def upd_admin
  	@user = User.find(params[:id])
  	if @user.update(admin_params)
  		if @user.code == ENV['ADMIN_CODE']
  			@user.toggle_admin
  			redirect_to users_admin_path
  			flash[:success] = "You are now a site administrator."
  		else
	  		redirect_to root_url
	  		flash[:danger] = "The code you entered was incorrect."
  		end
  	else
			redirect_to edit_admin_path
			flash[:danger] = "Error: Please try agian."
  	end
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

  private
	  def admin_params
	    params.require(:user).permit(:admin_code)
	  end
end
