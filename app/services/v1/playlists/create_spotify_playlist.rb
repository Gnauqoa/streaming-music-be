module V1
  module Playlists
    class CreateSpotifyPlaylist < ServiceBase
      attr_reader :playlist, :access_token

      def initialize(playlist:, access_token:)
        @playlist = playlist
        @access_token = access_token
      end

      def call
        headers = {
          'Authorization' => "Bearer #{access_token}"
        }
        new_playlist = false
        artists_clone = 0
        musics_clone = 0
        current_playlist = Playlist.find_by(playlist_external_id: playlist['id'])
        playlist_detail = HTTParty.get("https://api.spotify.com/v1/playlists/#{playlist['id']}", headers:)
        if current_playlist.present?
          current_playlist.update!(
            name: playlist_detail['name'],
            description: playlist_detail['description'],
            images: playlist_detail['images'],
            total_tracks: playlist_detail['tracks']['total'],
            likes_count: playlist_detail['followers']['total']
          )
        else
          new_playlist = true
          current_playlist = Playlist.create!(
            name: playlist_detail['name'],
            description: playlist_detail['description'],
            playlist_external_id: playlist_detail['id'],
            images: playlist_detail['images'],
            total_tracks: playlist_detail['tracks']['total'],
            status: :show,
            user_id: User.first.id,
            likes_count: playlist_detail['followers']['total']
          )
        end
        playlist_detail['tracks']['items'].each do |track|
          result = Musics::CreateSpotifyMusic.new(track: track['track'], access_token:).call
          artists_clone += result[:artists_clone]
          musics_clone += 1 if result[:new_music]
          PlaylistMusic.create!(playlist_id: current_playlist.id, music_id: result[:music].id) if PlaylistMusic.find_by(playlist_id: current_playlist.id, music_id: result[:music].id).nil?
        end
        { new_playlist:, musics_clone:, artists_clone: }
      end
    end
  end
end