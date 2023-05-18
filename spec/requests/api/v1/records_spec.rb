# rubocop:disable Metrics/BlockLength
require 'swagger_helper'

# it do
#   p '########################################################'
#   p request
#   p request.body.string
#   p '########################################################'
# end

RSpec.describe 'api/v1/records', type: :request do
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

  path '/api/v1/records' do
    get('list records') do
      consumes 'application/json'
      produces 'application/json'

      response 200, 'OK' do
        schema(
          {
            type: :object,
            properties: {
              records: { type: :array, items: { '$ref' => '#/components/schemas/Record' } }
            },
            required: %w[
              records
            ]
          }
        )

        run_test!
      end
    end

    post('create record') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :Body, in: :body, schema: {
        type: :object,
        properties: {
          record: {
            type: :object,
            properties: {
              travelled_distance: { type: :number, example: 287.27674272098625 }
            },
            required: %w[
              travelled_distance
            ]
          },
          token: { type: :string, example: '123adf123' }
        },
        required: %w[
          record
          token
        ]
      }

      response 201, 'Created' do
        let(:Body) { test_record }

        schema '$ref' => '#/components/schemas/User'

        run_test!
      end
    end
  end

  path '/api/v1/records/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show record') do
      consumes 'application/json'
      produces 'application/json'

      response 200, 'OK' do
        schema '$ref' => '#/components/schemas/Record'

        let(:record) do
          Api::V1::Record.create(
            travelled_distance: 287.00,
            user:
          )
        end

        let(:id) { record.id }

        run_test!
      end
    end

    patch('update record') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :Body, in: :body, schema: {
        type: :object,
        properties: {
          record: {
            type: :object,
            properties: {
              travelled_distance: { type: :number, example: 287.27674272098625 }
            },
            required: %w[
              travelled_distance
            ]
          },
          token: { type: :string, example: '123adf123' }
        },
        required: %w[
          record
          token
        ]
      }

      response 200, 'OK' do
        schema '$ref' => '#/components/schemas/Record'

        let(:record) do
          Api::V1::Record.create(
            travelled_distance: 10.00,
            user:
          )
        end

        let(:id) { record.id }

        let(:Body) { test_record }

        run_test!
      end
    end

    put('update record') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :Body, in: :body, schema: {
        type: :object,
        properties: {
          record: {
            type: :object,
            properties: {
              travelled_distance: { type: :number, example: 287.27674272098625 }
            },
            required: %w[
              travelled_distance
            ]
          },
          token: { type: :string, example: '123adf123' }
        },
        required: %w[
          record
          token
        ]
      }

      response 200, 'OK' do
        schema '$ref' => '#/components/schemas/Record'

        let(:record) do
          Api::V1::Record.create(
            travelled_distance: 10.00,
            user:
          )
        end

        let(:id) { record.id }

        let(:Body) { test_record }

        run_test!
      end
    end

    delete('delete record') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :Body, in: :body, schema: {
        type: :object,
        properties: {
          token: { type: :string, example: '123adf123' }
        },
        required: %w[
          token
        ]
      }

      response(204, 'No Content') do
        let(:record) do
          Api::V1::Record.create(
            travelled_distance: 10.00,
            user:
          )
        end

        let(:id) { record.id }

        let(:Body) { test_record }

        run_test!
      end
    end
  end

  path '/api/v1/users/{user_id}/records' do
    # You'll want to customize the parameter types...
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'

    get('index_with_user record') do
      consumes 'application/json'
      produces 'application/json'

      response 200, 'OK' do
        schema(
          {
            type: :object,
            properties: {
              records: { type: :array, items: { '$ref' => '#/components/schemas/Record' } }
            },
            required: %w[
              records
            ]
          }
        )

        let(:user_id) { user.id }

        run_test!
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
