# frozen_string_literal: true

module V1
  class Platforms < Base
    resources :platforms do
      desc 'This API allows admins to create a new platform',
           summary: 'Create platform',
           success: { code: 201, model: Entities::V1::PlatformResponse },
           headers: {
             'Client-ID' => {
               description: 'The platform client ID',
               required: true
             }
           }
      params do
        requires :name, type: String, desc: 'Platform name', documentation: { param_type: 'body' }
      end
      post do
        authorize!
        status 201
        handle_create_or_update
      end

      desc 'This API allows admins to update an existing platform',
           summary: 'Update platform',
           success: { code: 200, model: Entities::V1::PlatformResponse },
           headers: {
             'Client-ID' => {
               description: 'The platform client ID',
               required: true
             }
           }
      params do
        requires :id, type: Integer, desc: 'Platform ID'
        optional :name, type: String, desc: 'Platform name', documentation: { param_type: 'body' }
      end
      put ':id' do
        authorize!
        status 200
        handle_create_or_update
      end
    end

    helpers do
      def authorize!
        authorize(:platform, :create?)
      end

      def handle_create_or_update
        result = ::Platforms::CreateOrUpdate.new(
          params: declared(params, include_missing: false)
        ).call

        if result.success?
          format_response(result.success)
        else
          error!(failure_response(*result.failure), 422)
        end
      end
    end
  end
end
