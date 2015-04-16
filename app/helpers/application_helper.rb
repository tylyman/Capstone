module ApplicationHelper

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping 
    @devise_mapping||= Devise.mappings[:user]
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def check_for_language(var)
    Obscenity.profane?(var.content)
  end

  def check_title_for_language_obscene(var)
    Obscenity.profane?(var.title)
  end
end
