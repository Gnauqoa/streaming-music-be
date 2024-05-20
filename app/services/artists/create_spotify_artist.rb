module Artists
  class CreateSpotifyArtist < ServiceBase
    attr_reader :artist

    def initialize(artist:)
      @artist = artist
    end

    def call
      current_artist = Artist.find_by(artist_external_id: artist['id'])
      if current_artist.present?
        Artist.update!(
          email: "#{artist['name'].split(' ')[0] + SecureRandom.hex[1..5]}@gmail.com",
          name: artist['name'],
          artist_external_id: artist['id'],
          images: artist['images'],
          genres: artist['genres'],
          followers_count: artist['followers']['total'],
          password: 'Artist@123'
        )
      else
        Artist.create!(
          email: "#{artist['name'].split(' ')[0] + SecureRandom.hex[1..5]}@gmail.com",
          name: artist['name'],
          artist_external_id: artist['id'],
          images: artist['images'],
          genres: artist['genres'],
          followers_count: artist['followers']['total'],
          password: 'Artist@123'
        )
      end
    end
  end
end
