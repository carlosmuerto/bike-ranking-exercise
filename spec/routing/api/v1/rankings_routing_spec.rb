require 'rails_helper'

RSpec.describe Api::V1::RankingsController, type: :routing do
  describe 'routing' do
    it 'routes to #index_by_year_and_month' do
      expect(
        get: '/api/v1/rankings/2000/1'
      ).to route_to('api/v1/rankings#index_by_year_and_month', year: '2000', month: '1', format: :json)
    end

    it 'routes to #index_by_year' do
      expect(
        get: '/api/v1/rankings/2000'
      ).to route_to('api/v1/rankings#index_by_year', year: '2000', format: :json)
    end

    it 'routes to #index_by_actual' do
      expect(
        get: '/api/v1/rankings/actual'
      ).to route_to('api/v1/rankings#index_by_actual', format: :json)
    end
  end
end
