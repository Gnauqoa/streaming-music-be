# frozen_string_literal: true

module Artists
  class PublicBase < Grape::API
    def self.inherited(subclass)
      super

      subclass.instance_eval do
        include BaseHelper
        use Middlewares::PublicAuthentication

        helpers do
          def client_id_key
            Middlewares::ArtistJwtAuthentication::CLIENT_ID_KEYS.detect { |key| env.key?(key) }
          end

          def platform
            @platform ||= Platform.find_by!('client_id = ? OR ? = ANY(hosts)', client_id, host)
          end

          def client_id
            env[client_id_key]
          end

          def host_key
            Middlewares::ArtistJwtAuthentication::HOST_KEYS.detect { |key| @env.key?(key) }
          end

          def client_ip
            env['action_dispatch.remote_ip'].to_s
          end

          def host
            @env[host_key]
          end
        end
      end
    end
  end
end
