module UsersHelper
	 def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def toggle_admin
  	self.admin = 'true'
  end
end
