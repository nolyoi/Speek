class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info, :notice, :alert, :primary
  helper_method :current_user, :current_ability, :is_shop_owner?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, danger: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

end