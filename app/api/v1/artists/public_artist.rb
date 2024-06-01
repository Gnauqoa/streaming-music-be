module V1
  module Artists
    class PublicArtist < PublicBase
      resources :artists do
        desc "Get artist profile", summary: "Get current artist"
        params do
          requires :id, type: Integer, desc: "Artist ID"
        end
        get ':id' do
          artist = Artist.find(params[:id])
          return error!(failure_response(:artist_not_found), 404) unless artist.present?
          format_response(artist)
        end
        desc "Get artist musics", summary: "Get artist musics"
        params do
          requires :id, type: Integer, desc: "Artist ID"
          optional :page, type: Integer, desc: "Page number"
          optional :per_page, type: Integer, desc: "Per page number", default: 50
        end
        get ':id/musics' do
          artist = Artist.find(params[:id])
          return error!(failure_response(:artist_not_found), 404) unless artist.present?
          musics = artist.musics
          paginated_response(musics)
        end
      end
    end
  end
end