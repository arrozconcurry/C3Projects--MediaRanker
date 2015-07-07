class AlbumsController < ApplicationController

  def index
    @media = Album.all.order(rank: :desc)
  end

  def show
    @album = Album.find(params[:id])
  end

    def new
    @album = Album.new
    end

  def create
    @album = Album.new(create_params[:album])
    @album.save
    redirect_to album_path(@album.id)
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    @album.update(create_params[:album])
    redirect_to album_path(@album.id)
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to albums_path
  end

  def add_a_vote
    @album = Album.find(params[:id])
    @album.rank += 1
  end

  def upvote
    @album = Album.find(params[:id])
    @album.add_a_vote
    @album.update(create_params[:rank])
    render :show
  end


  private

  def create_params
    params.permit(album: [:name, :artist, :description, :rank])
  end


end
