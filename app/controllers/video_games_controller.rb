class VideoGamesController < ApplicationController
  def index
    @video_games = VideoGame.all

    render :index
  end

  def show
    @video_game_id = params[:id]
    @video_game = VideoGame.find(@video_game_id)

    render :show
  end

  # Add a new Video Game
  def new
    @video_game = VideoGame.new(video_game_params[:video_game])
  end

  def create
    @video_game = VideoGame.create(video_game_params[:video_game])
    if @video_game.save
      redirect_to video_game_path(@video_game.id)
    else
      flash[:error] = "You must include a title."
      redirect_to new_video_game_path
    end
  end

  # Upvote an existing Video Game
  def upvote
    @video_game_id = params[:id]
    @video_game = VideoGame.find(@video_game_id)
    @video_game.rating += 1
    @video_game.save

    redirect_to video_game_path(@video_game.id)
  end

  # Update an existing Video Game
  def edit
    @video_game_id = params[:id]
    @video_game = VideoGame.find(@video_game_id)

    render :edit
  end

  def update
    @video_game_id = params[:id]
    @video_game = VideoGame.find(@video_game_id)
    @video_game.update(video_game_params[:video_game])

    redirect_to video_game_path(@video_game.id)
  end

  def destroy
    @video_game_id = params[:id]
    @video_game = VideoGame.find(@video_game_id)

    @video_game.destroy
    redirect_to video_games_path
  end

  private

  def video_game_params
    params.permit(video_game: [:title, :description, :studio, :stars])
  end

end