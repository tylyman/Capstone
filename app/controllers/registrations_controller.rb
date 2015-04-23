class RegistrationsController < Devise::RegistrationsController

	def edit
    store_return_to

    respond_to do |format|
      format.html
      format.js
    end
  end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: session[:return_to] || root_url
      session[:return_to] = nil
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

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

	  def store_return_to
	    session[:return_to] = request.referer
		end
end
