class Api::V1::UsersController < ApplicationController
  before_action :set_api_v1_user, only: %i[show update destroy]

  # GET /api/v1/users
  def index
    @api_v1_users = Api::V1::User.all.page(params[:page])
  end

  # GET /api/v1/users/1
  def show; end

  # GET /api/v1/users/current_user
  def current
    @api_v1_user = current_user
  end

  # GET /api/v1/users/loguot
  def logout
    @api_v1_user = current_user
    return unless @api_v1_user

    @api_v1_user.token = nil
    @api_v1_user.save
    render 'logout' if @api_v1_user
  end

  # GET /api/v1/users/login
  def login
    login_params = params.require(:user).permit(:email, :password)
    @api_v1_user = Api::V1::User.find_by(email: login_params[:email])

    if @api_v1_user&.authenticate(login_params[:password])
      # authenticated successfully
      @api_v1_user.regenerate_token
      render 'login', status: :ok
    else
      # authentication failed
      render 'login_failed', status: :unauthorized
    end
  end

  # POST /api/v1/users
  def create
    @api_v1_user = Api::V1::User.new(api_v1_user_params)

    if @api_v1_user.save
      render 'show', status: :created, location: @api_v1_user
    else
      render 'errors', status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/users/1
  def update
    return unless @api_v1_user == current_user

    if @api_v1_user.update(api_v1_user_params)
      render 'show'
    else
      render 'errors', status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/users/1
  def destroy
    return unless @api_v1_user == current_user

    @api_v1_user.destroy
  end

  private

  def authenticate_user!
    # authentication failed
    render 'login_failed', status: :unauthorized unless @api_v1_user&.authenticate(login_params[:password])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_api_v1_user
    @api_v1_user = Api::V1::User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def api_v1_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
