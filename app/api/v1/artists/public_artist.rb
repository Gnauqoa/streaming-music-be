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
      end
    end
  end
end