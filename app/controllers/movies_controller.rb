class MoviesController < ApplicationController

  def index
   @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(create_params[:movie])
    @movie.rank = 0

    if @movie.save
      render :show
    else
      render :new
    end
# redirect_to movie_path(@movie.id)
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])

    name_input = params[:movie][:name]
    director_input = params[:movie][:director]
    description_input = params[:movie][:description]

    @movie.update(name: name_input, director: director_input , description: description_input)

    if @movie.save
      redirect_to movies_path(@movie.id)
    else
      render :edit
    end


    # redirect_to movie_path(@movie.id) #movie/:id
  end
# @movie.ranking +=1
    # def upvote
    #   @movie = Movie.find(params[:id])
    #   @movie.votes.create
    #   redirect_to movies_path(@movie.id)
    # end


  def destroy
    Movie.destroy(params[:id])
    redirect_to '/movies'
  end

  private

  def edit_params
    params.permit(movie: [:name, :director, :description])
  end

  def create_params
    params.permit(movie: [:name, :director, :description])
  end

end
