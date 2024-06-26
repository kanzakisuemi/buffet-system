class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :buffet_yet_to_be_registered, if: :user_signed_in?

  protected

  def buffet_yet_to_be_registered
    if current_user.business_owner? && current_user.buffet.nil?
      unless url_for(only_path: true) == destroy_user_session_path || url_for(only_path: true) == new_buffet_path || url_for(only_path: true) == buffets_path
        redirect_to new_buffet_path
      end
    end
  end

  def after_sign_in_path_for(user)
    if user.business_owner?
      user.buffet ? root_path() : new_buffet_path()
    else
      root_path()
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name role social_security_number])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[name role social_security_number])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name role social_security_number])
  end
end
