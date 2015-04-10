class RegistrationsController < Devise::RegistrationsController
  private

	  def sign_up_params
	   params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :age, :admin, :user_name, :dob)
	  end

	  def account_update_params
	   params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :age, :admin, :user_name, :dob)
	  end
end
