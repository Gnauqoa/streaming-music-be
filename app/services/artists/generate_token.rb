# frozen_string_literal: true

module Artists
  class GenerateToken < ServiceBase
    def initialize(artist:)
      @artist = artist
    end

    def call
      generate_token
    end

    private

    attr_reader :artist

    def private_key
      OpenSSL::PKey::RSA.new(ENV['ARTIST_JWT_PRIVATE_KEY'].gsub('\\n', "\n"))
    end

    def generate_token
      token = JWT.encode(artist.decorate.jwt_payload, private_key, 'RS256')
      Success(token)
    end
  end
end
