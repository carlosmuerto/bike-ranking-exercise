# rubocop:disable Metrics/BlockLength
require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do
  let!(:test_user) do
    {
      name: 'test',
      email: 'test@test.com',
      password: 'testPassword',
      password_confirmation: 'testPassword'
    }
  end

  let(:user_before) do
    u = Api::V1::User.create test_user
    u.regenerate_token
    u
  end

  let(:updated_user) do
    {
      name: 'changedTest',
      email: 'changedTest@test.com',
      password: 'changedTestPassword',
      password_confirmation: 'changedTestPassword'
    }
  end

  path '/api/v1/users' do
    get('list users') do
      consumes 'application/json'
      produces 'application/json'

      response 200, 'OK' do
        schema(
          {
            type: :object,
            properties: {
              users: { type: :array, items: { '$ref' => '#/components/schemas/Record' } },
              specialization: { type: :string, example: 'specialization' }
            }
          }
        )

        run_test!
      end
    end

    post('create user') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :Body, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              name: { type: :string, example: 'test' },
              email: { type: :string, example: 'test@test.com' },
              password: { type: :string, example: 'testPassword' },
              password_confirmation: { type: :string, example: 'testPassword' }
            },
            required: %w[
              name
              email
              password
              password_confirmation
            ]
          }
        },
        required: %w[
          user
        ]
      }

      response 201, 'Created' do
        let(:Body) do
          {
            user: test_user
          }
        end

        schema '$ref' => '#/components/schemas/User'

        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show user') do
      consumes 'application/json'
      produces 'application/json'

      response 200, 'OK' do
        schema '$ref' => '#/components/schemas/User'

        let(:user) { Api::V1::User.create test_user }

        let(:id) { user.id }

        run_test!
      end
    end

    patch('update user') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :Body, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              name: { type: :string, example: 'test' },
              email: { type: :string, example: 'test@test.com' },
              password: { type: :string, example: 'testPassword' },
              password_confirmation: { type: :string, example: 'testPassword' }
            }
          },
          token: { type: :string, example: '123adf123' }
        },
        required: %w[
          token
          user
        ]
      }

      response 200, 'OK' do
        schema '$ref' => '#/components/schemas/User'

        let(:Body) do
          {
            user: updated_user,
            token: user_before.token
          }
        end

        let(:id) { user_before.id }

        run_test!
      end
    end

    put('update user') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :Body, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              name: { type: :string, example: 'test' },
              email: { type: :string, example: 'test@test.com' },
              password: { type: :string, example: 'testPassword' },
              password_confirmation: { type: :string, example: 'testPassword' }
            }
          },
          token: { type: :string, example: '123adf123' }
        },
        required: %w[
          token
          user
        ]
      }

      response 200, 'OK' do
        schema '$ref' => '#/components/schemas/User'

        let(:Body) do
          {
            user: updated_user,
            token: user_before.token
          }
        end

        let(:id) { user_before.id }

        run_test!
      end
    end

    delete('delete user') do
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
        let(:id) { user_before.id }

        let(:Body) do
          {
            token: user_before.token
          }
        end

        run_test!
      end
    end
  end

  path '/api/v1/users/login' do
    post('login') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :Body, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, example: 'test@test.com' },
              password: { type: :string, example: 'testPassword' }
            },
            required: %w[
              email
              password
            ]
          }
        },
        required: %w[
          user
        ]
      }

      response 200, 'OK' do
        schema '$ref' => '#/components/schemas/User'

        let(:Body) do
          {
            user: {
              email: test_user[:email],
              password: test_user[:password]
            }
          }
        end

        before do
          Api::V1::User.create test_user
        end

        run_test!
      end
    end
  end

  path '/api/v1/users/logout' do
    post('logout') do
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

      response(200, 'OK') do
        let(:id) { user_before.id }

        let(:Body) do
          {
            token: user_before.token
          }
        end

        run_test!
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
