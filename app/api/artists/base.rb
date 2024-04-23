# frozen_string_literal: true

module Artists
  class Base < Grape::API
    def self.inherited(subclass)
      super

      subclass.instance_eval do
        include BaseHelper
        use Middlewares::ArtistJwtAuthentication

        helpers do
          def remote_artist
            env['REMOTE_ARTIST']
          end

          def artist_id
            remote_artist['id']
          end

          def current_artist
            return @current_artist if defined? @current_artist

            @current_artist = Artist.find(artist_id)
          end

          def client_ip
            env['action_dispatch.remote_ip'].to_s
          end
        end
      end
    end
  end
end
