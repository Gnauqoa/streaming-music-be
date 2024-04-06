# frozen_string_literal: true

module V1
  class PublicBase < Grape::API
    def self.inherited(subclass)
      super

      subclass.instance_eval do
        include BaseHelper

        helpers do
          def client_id_key
            Middlewares::JwtAuthentication::CLIENT_ID_KEYS.detect { |key| env.key?(key) }
          end

          def platform
            @platform ||= Platform.find_by!('client_id = ? OR ? = ANY(hosts)', client_id, host)
          end

          def client_id
            env[client_id_key]
          end

          def host_key
            Middlewares::JwtAuthentication::HOST_KEYS.detect { |key| @env.key?(key) }
          end

          def host
            @env[host_key]
          end
        end
      end
    end
  end
end
