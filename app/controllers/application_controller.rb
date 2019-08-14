class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def authenticate_user!
    if current_user == nil
      redirect_to("/sign_in", { :alert => "You must be signed in." })
    end
  end

  helper_method :current_user

  def current_user
    if @current_user == nil
      @current_user = User.where({ :id => session[:user_id] }).at(0)
    end

    return @current_user
  end
end
