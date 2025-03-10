class ApplicationController < ActionController::API
  include ActionController::Cookies

  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_entity_res
  before_action :authorize

  def authorize
    @current_user = User.find_by(id: session[:user_id])
    render json: { errors: ["Not authorized"]}, status: :unauthorized unless @current_user
  end 

  def render_invalid_entity_res(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end 

end
