class ApplicationController < ActionController::API
  private

  def current_user
    return unless params[:token]

    user = Api::V1::User.find_by_token(params[:token])
    # authentication failed
    render 'auth_failed', status: :unauthorized unless user

    user
  end
end
