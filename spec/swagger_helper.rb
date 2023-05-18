# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      components: {
        schemas: {
          Record: {
            type: :object,
            properties: {
              id: { type: :string, example: '52df1d2f-3284-4e34-b3fc-daa32f4c41d5' },
              travelled_distance: { type: :number, example: 287.27674272098625 },
              created_at: { type: :string, example: '2021-12-13T16:55:40.437Z' }
            }
          },
          User: {
            type: :object,
            properties: {
              id: { type: :string, example: '52df1d2f-3284-4e34-b3fc-daa32f4c41d5' },
              name: { type: :string, example: 'Scott Wells' },
              email: { type: :string, example: 'scott_wells@test.com' }
            }
          },
          Rank: {
            type: :object,
            properties: {
              rank: { type: :integer, example: 1 },
              travelled_distance: { type: :number, example: 287.27674272098625 },
              user: { '$ref' => '#/components/schemas/User' }
            }
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end

# rubocop:enable Metrics/BlockLength
