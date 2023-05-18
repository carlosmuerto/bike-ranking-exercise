class Api::V1::RecordsController < ApplicationController
  before_action :set_api_v1_record, only: %i[show update destroy]

  # GET /api/v1/records
  def index
    @api_v1_records = Api::V1::Record.all

    render json: @api_v1_records
  end

  # GET /api/v1/records/1
  def show
    render json: @api_v1_record
  end

  # POST /api/v1/records
  def create
    @api_v1_record = Api::V1::Record.new(api_v1_record_params)

    if @api_v1_record.save
      render json: @api_v1_record, status: :created, location: @api_v1_record
    else
      render json: @api_v1_record.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/records/1
  def update
    if @api_v1_record.update(api_v1_record_params)
      render json: @api_v1_record
    else
      render json: @api_v1_record.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/records/1
  def destroy
    @api_v1_record.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_api_v1_record
    @api_v1_record = Api::V1::Record.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def api_v1_record_params
    params.require(:api_v1_record).permit(:travelled_distance, :user_id)
  end
end
