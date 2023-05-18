# rubocop:disable Metrics/BlockLength
require 'swagger_helper'

RSpec.describe 'api/v1/rankings', type: :request do
  let(:user) do
    u = Api::V1::User.create(
      {
        name: 'test',
        email: 'test@test.com',
        password: 'testPassword',
        password_confirmation: 'testPassword'
      }
    )
    u.regenerate_token
    u
  end

  let!(:test_record) do
    {
      record: {
        travelled_distance: 287.00
      },
      token: user.token
    }
  end

  path '/api/v1/rankings/actual' do
    get('index_by_actual ranking') do
      consumes 'application/json'
      produces 'application/json'

      response 200, 'OK' do
        schema type: :array, items: { '$ref' => '#/components/schemas/Rank' }

        run_test!
      end
    end
  end

  path '/api/v1/rankings/{year}/{month}' do
    parameter name: 'year', in: :path, type: :string, description: 'year'
    parameter name: 'month', in: :path, type: :string, description: 'month'

    get('ranking by year and month') do
      response(200, 'successful') do
        consumes 'application/json'
        produces 'application/json'

        let(:year) { '2000' }
        let(:month) { '1' }
  
        response 200, 'OK' do
          schema type: :array, items: { '$ref' => '#/components/schemas/Rank' }
  
          run_test!
        end
      end
    end
  end

  path '/api/v1/rankings/{year}' do
    parameter name: 'year', in: :path, type: :string, description: 'year'

    get('index_by_year ranking') do
      response(200, 'successful') do
        consumes 'application/json'
        produces 'application/json'

        let(:year) { '2000' }
  
        response 200, 'OK' do
          schema type: :array, items: { '$ref' => '#/components/schemas/Rank' }
  
          run_test!
        end
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
