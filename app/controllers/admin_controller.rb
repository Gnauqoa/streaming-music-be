class AdminController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protect_from_forgery prepend: true
  layout :layout
  
  
  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
  def layout
    is_a?(Devise::SessionsController) ? 'auth' : 'admin'
  end

end