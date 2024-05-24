# frozen_string_literal: true

module Artists
  class Create < ServiceBase
    def initialize(params:)
      @params = params
    end

    def call
      create_artist
    end

    private

    attr_reader :params

    def create_artist
      artist = Artist.new(params)
      if artist.save
        Success(artist)
      else
        Failure[:create_failed, artist.errors.full_messages]
      end
    end
  end
end
