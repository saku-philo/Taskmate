class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_required

  class Forbidden < ActionController::ActionControllerError
  end

  rescue_from Forbidden, with: :rescue403

  private

  def login_required
    redirect_to new_session_path unless current_user
  end

  def rescue403(e)
    @exception = e
    render 'errors/forbidden', status: 403
  end
end
