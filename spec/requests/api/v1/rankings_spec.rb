# rubocop:disable Metrics/BlockLength
require 'swagger_helper'

RSpec.describe 'api/v1/rankings', type: :request do
  path '/api/v1/rankings/actual' do
    get('index_by_actual ranking') do
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/rankings/{year}/{month}' do
    # You'll want to customize the parameter types...
    parameter name: 'year', in: :path, type: :string, description: 'year'
    parameter name: 'month', in: :path, type: :string, description: 'month'

    get('index_by_year_and_month ranking') do
      response(200, 'successful') do
        let(:year) { '123' }
        let(:month) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/rankings/{year}' do
    # You'll want to customize the parameter types...
    parameter name: 'year', in: :path, type: :string, description: 'year'

    get('index_by_year ranking') do
      response(200, 'successful') do
        let(:year) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
