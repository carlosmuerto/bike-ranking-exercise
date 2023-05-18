class Api::V1::RecordsController < ApplicationController
  before_action :set_api_v1_record, only: %i[show update destroy]

  # GET /api/v1/users/:user_id/records
  def index_with_user
    @api_v1_records = Api::V1::User.find(params[:user_id]).records.page(params[:page])
    render 'index'
  end

  # GET /api/v1/records
  def index
    @api_v1_records = Api::V1::Record.all.page(params[:page])
  end

  # GET /api/v1/records/1
  def show; end

  # POST /api/v1/records
  def create
    @api_v1_record = Api::V1::Record.new(api_v1_record_params)

    return unless current_user

    @api_v1_record.user = current_user

    if @api_v1_record.save
      render 'show', status: :created, location: @api_v1_record
    else
      render 'errors', status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/records/1
  def update
    return unless @api_v1_record.user == current_user

    if @api_v1_record.update(api_v1_record_params)
      render 'show'
    else
      render 'errors', status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/records/1
  def destroy
    return unless @api_v1_record.user == current_user

    @api_v1_record.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_api_v1_record
    @api_v1_record = Api::V1::Record.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def api_v1_record_params
    params.require(:record).permit(:travelled_distance)
  end
end
