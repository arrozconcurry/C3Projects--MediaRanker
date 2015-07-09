class MoviesController < ApplicationController
  def index
    @movies = Movie.all.order('ranking DESC')
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    movie = Movie.find(params[:id])
    updated_movie = create_params[:movie]
    # opportunity for .valid? and error handling
    movie.update(updated_movie)

    redirect_to movie_path(movie)
  end

  def destroy
    movie = Movie.find(params[:id])
    movie.destroy

    redirect_to media_path
  end

  private

  def create_params
    params.permit(movie: [:title, :director, :description])
  end
end
