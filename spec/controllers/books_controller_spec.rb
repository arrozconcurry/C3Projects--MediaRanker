require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    before :each do
      @book = Book.create(title: 'a')
    end

    it "returns http success" do
      get :show, id: @book
      expect(response).to be_success
    end

    it "renders the show view" do
      get :show, id: @book
      expect(response).to render_template("show")
    end
  end

  describe "GET #edit" do
    before :each do
      @book = Book.create(title: 'a')
    end

    it "renders the edit view" do
      get :edit, id: @book
      expect(response).to render_template("edit")
    end
  end

  describe "PUT #update" do
    describe "upvote" do
      before :each do
        @book = Book.create(title: 'a')
      end

      it "updates votes" do
        put :update, id: @book, upvote: "true"
        expect(Book.find(1).votes).to eq 1
      end

      it "redirects to book show view" do
        put :update, id: @book, votes: @book, upvote: "true"
        expect(subject).to redirect_to(book_path(@book))
      end
    end

    describe "editing a book" do
      context "valid book params" do
        before :each do
          @book = Book.create(title: 'a')
        end

        it "updates a book" do
          put :update, id: @book, book: { title: 'b'}
          @book.reload
          expect(@book.title).to eq 'b'
        end

        it "redirects to book show view" do
          put :update, id: @book, book: { title: 'b'}
          @book.reload
          expect(response).to redirect_to(book_path(@book))
        end
      end

      context "invalid book params" do
        before :each do
          @book = Book.create(title: 'a')
        end

        it "does not update the book" do
          put :update, id: @book, book: { title: '' }
          @book.reload
          expect(@book.title).to eq 'a'
        end

        it "renders the edit page so the record can be fixed" do
          put :update, id: @book, book: { title: '' }
          @book.reload
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
    context "valid book params" do
      let(:book) do
        {
          book: {
            title: 'a'
          }
        }
      end

      it "creates a book" do
        post :create, book
        expect(Book.count).to eq 1
      end

      it "redirects to the book show page" do
        post :create, book
        expect(subject).to redirect_to(book_path(assigns(:book)))
      end
    end

    context "invalid book params" do
      let(:book) do
        {
          book: { title: '' }
        }
      end

      it "does not persist invalid records" do
        post :create, book
        expect(Book.count).to eq 0
      end

      it "renders the new page so the record can be fixed" do
        post :create, book
        expect(response).to render_template("new")
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @book = Book.create(title: 'a')
    end

    it "deletes a book" do
      post :destroy, id: @book
      expect(Book.count).to eq 0
    end

    it "redirects to the book index page" do
      post :destroy, id: @book
      expect(subject).to redirect_to(books_path)
    end
  end
end
