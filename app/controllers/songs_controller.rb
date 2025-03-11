class SongsController < ApplicationController
  def index
    @songs = Song.where('title ILIKE ?', "%#{params[:q]}%")
    render json: @songs.map { |song| { id: song.id, title: song.title } }
  end
end
