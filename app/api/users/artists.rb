module Users
  class Artists < PublicBase
    resources :artists do
      desc 'Get artist information',
           summary: 'Get artist information'
      params do
        requires :id, type: Integer, desc: 'Artist ID'
      end
      get ':id' do
        artist = Artist.find(params[:id])
        return error!([:artist_not_found], 401) if artist.nil?

        format_response(artist)
      end
    end
  end
end
