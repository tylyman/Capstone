class RegistrationsController < Devise::RegistrationsController
  
	protected

	def update_resource(resource, params)
		resource.update_without_password(params)
	end

  private

	  def sign_up_params
	   params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :age, :admin, :user_name, :dob, :uid, :provider)
	  end

	  def account_update_params
	   params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :age, :admin, :user_name, :dob, :uid, :provider)
	  end
end
