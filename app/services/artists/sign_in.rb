# frozen_string_literal: true

module Artists
  class SignIn < ServiceBase
    def initialize(email:, password:, request:)
      @email = email
      @password = password
      @request = request
    end

    def call
      yield find_artist
      yield valid_password?
      token = yield generate_token
      artist.update_tracked_fields(request)
      artist.save
      Success(token)
    end

    private

    attr_reader :artist, :email, :password, :request

    def find_artist
      return Failure[:email_or_wallet_address_is_required, 'Email is required'] unless email

      @artist = Artist.find_by(email:)

      return Failure[:invalid_username_or_password, 'Invalid email or password'] unless artist

      Success(artist)
    end

    def valid_password?
      if artist.valid_password?(password)
        Success(artist)
      else
        Failure[:invalid_username_or_password, 'Invalid email or password']
      end
    end

    def generate_token
      GenerateToken.new(artist:).call
    end
  end
end
