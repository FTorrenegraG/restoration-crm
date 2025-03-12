class SongsController < ApplicationController
  def index
    @songs = Song.where('title ILIKE ?', "%#{params[:q]}%")
    render json: @songs.select(:id, :title, :performer, :key, :song_type)
  end
end
