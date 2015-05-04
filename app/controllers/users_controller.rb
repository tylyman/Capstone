class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @transactions = @user.transactions
  end

  # Edits the admin state of the user, not the user registration.
  def edit_admin
  	@user = User.find(params[:id])

  	respond_to do |format|
      format.html
      format.js
    end
  end

  # Checks to see if the user is authorized to become an Admin and updates user admin column.
  def upd_admin
  	@user = User.find(params[:id])
  	if @user.update(admin_params)
  		if @user.admin_code == ENV['ADMIN_CODE']
  			@user.admin = true
  			@user.save
  			redirect_to admin_path(@user)
  			flash[:success] = "You are now a site administrator."
  		else
	  		redirect_to user_path(@user)
	  		flash[:danger] = "The code you entered was incorrect."
  		end
  	else
			redirect_to user_path(@user)
			flash[:danger] = "Error: Please try agian."
  	end
  end

  # Admin portal.
  def admin
  	@user = User.find(params[:id])
  	@users = User.all
  	@events = Event.all
  	@questions = Question.all
  	@answers = Answer.all

    @admin_count = User.where(:admin => true).count
    @users_count = User.where(:admin => false).count

  	if !current_user.admin?
			flash[:danger] = "You are not authorized to view this page."
 	  	redirect_to root_url
		end
  end

  def destroy
    if !current_user.admin?
      flash[:danger] = "You are not authorized to complete this action."
      redirect_to root_url
      else
      @user = User.find(params[:id])
      @user.destroy

      if @user.destroy
          redirect_to admin_path(:id => current_user.id)
          flash[:success] = "The account was succesfully deleted."
      end
    end
  end

  private
	  def admin_params
	    params.require(:user).permit(:admin_code)
	  end
end
