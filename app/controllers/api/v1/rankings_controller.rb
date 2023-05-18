class Api::V1::RankingsController < ApplicationController
  def index_by_year_and_month
    year = params[:year].to_i
    month = params[:month].to_i
    start_date = DateTime.new(year, month, 1)
    end_date = start_date.end_of_month

    set_api_v1_rankings(start_date, end_date)

    render 'index'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_api_v1_rankings(start_date, end_date)
    users = Api::V1::User.with_most_traveled_distance(start_date, end_date)
    @user_rankings = users.each_with_index.map do |user, index|
      { rank: index + 1, user:, travelled_distance: user.travelled_distance(start_date, end_date) }
    end

    @user_rankings = Kaminari.paginate_array(@user_rankings).page(params[:page])
  end
end
