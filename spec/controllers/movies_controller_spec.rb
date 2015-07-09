require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    before :each do
      @movie = Movie.create(title: 'a')
    end

    it "returns http success" do
      get :show, id: @movie
      expect(response).to be_success
    end

    it "renders the show view" do
      get :show, id: @movie
      expect(response).to render_template("show")
    end
  end

  describe "GET #edit" do
    before :each do
      @movie = Movie.create(title: 'a')
    end

    it "renders the edit view" do
      get :edit, id: @movie
      expect(response).to render_template("edit")
    end
  end

  describe "PUT #update" do
    describe "upvote" do
      before :each do
        @movie = Movie.create(title: 'a')
      end

      it "updates votes" do
        put :update, id: @movie, upvote: "true"
        expect(Movie.find(1).votes).to eq 1
      end

      it "redirects to movie show view" do
        put :update, id: @movie, upvote: "true"
        expect(subject).to redirect_to(movie_path(@movie))
      end
    end

    describe "editing a movie" do
      context "valid movie params" do
        before :each do
          @movie = Movie.create(title: 'a')
        end

        it "updates a movie" do
          put :update, id: @movie, movie: { title: 'b'}
          @movie.reload
          expect(@movie.title).to eq 'b'
        end

        it "redirects to movie show view" do
          put :update, id: @movie, movie: { title: 'b'}
          @movie.reload
          expect(response).to redirect_to(movie_path(@movie))
        end
      end

      context "invalid movie params" do
        before :each do
          @movie = Movie.create(title: 'a')
        end

        it "does not update the movie" do
          put :update, id: @movie, movie: { title: '' }
          @movie.reload
          expect(@movie.title).to eq 'a'
        end

        it "renders the edit page so the record can be fixed" do
          put :update, id: @movie, movie: { title: '' }
          @movie.reload
          expect(response).to render_template("edit")
        end
      end
    end
  end

  describe "GET #new" do
    it "renders the new view" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "valid movie params" do
      let(:movie) do
        {
          movie: {
            title: 'a'
          }
        }
      end

      it "creates a movie" do
        post :create, movie
        expect(Movie.count).to eq 1
      end

      it "redirects to the movie show page" do
        post :create, movie
        expect(subject).to redirect_to(movie_path(assigns(:movie)))
      end
    end

    context "invalid movie params" do
      let(:movie) do
        {
          movie: { title: '' }
        }
      end

      it "does not persist invalid records" do
        post :create, movie
        expect(Movie.count).to eq 0
      end

      it "renders the new page so the record can be fixed" do
        post :create, movie
        expect(response).to render_template("new")
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @movie = Movie.create(title: 'a')
    end

    it "deletes a movie" do
      post :destroy, id: @movie
      expect(Movie.count).to eq 0
    end

    it "redirects to the movie index page" do
      post :destroy, id: @movie
      expect(subject).to redirect_to(movies_path)
    end
  end
end
