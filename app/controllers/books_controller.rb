class BooksController < ApplicationController
  def index
    @books = policy_scope(Book)
    if params[:query].present?
      @books = Book.search_books(params[:query]).page(params[:page])
    else
      @books = Book.available.page(params[:page])
    end
  end

  def show
    @book = Book.find(params[:id])
    authorize @book
    @transaction = Trade.new
    @books = Book.available.where(user: current_user).order(:title)
    @markers = [
      {
        lat: @book.latitude,
        lng: @book.longitude
      }]
    reviews = Review.where("sender_id = ?", @book.user.id)
    if reviews.empty?
      @reputation = 0.0
    else
      scores = reviews.map(&:score)
      @reputation = scores.inject { |sum, el| (sum + el) }.to_f / reviews.size
    end
  end

  def new
    @book = Book.new
    authorize @book
  end

  def autocomplete
    @books = policy_scope(Book).get_book_attributes(params[:q])
    unless @books.empty?
      render partial: "book", collection: @books, formats: :html
    end
  end

  def build
    @book = Book.new(build_params[:book])
    @book.user = current_user
    authorize @book
    if @book.save
      flash[:notice] = "You added this book!"
      redirect_to edit_book_path(@book)
    end
  end

  def create
    @book = Book.find(book_params_edit)
    authorize @book
    @book.description = book_params_edit[:description]
    if @book.update(book_params_edit)
      flash[:notice] = "Your book was added!"
      redirect_to book_path(@book)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @book = Book.find(params[:id])
    authorize @book
  end

  def update
    @book = Book.find(params[:id])
    authorize @book
    @book.address = current_user.address
    if @book.update(book_params_edit)
      flash[:notice] = "You updated this book!"

      redirect_to book_path(@book), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find(params[:id])
    authorize @book
    @book.destroy
    flash[:notice] = "Your book was deleted"
    redirect_to books_path, status: :see_other
  end

  def my
    @books = policy_scope(Book).where(user: current_user)
  end

  def stash
    @book = Book.find(params[:book_id])
    authorize @book
    @books = policy_scope(Book).where(user: @book.user)
  end

  private

  def book_params_edit
    params.require(:book).permit(:description, :id)
  end

  def book_params_new
    params.require(:book).permit(:title,
                                 :author,
                                 :thumbnail,
                                 :published_date,
                                 :description,
                                 :synopsis,
                                 :rating,
                                 :user_id,
                                 :address,
                                 :latitude,
                                 :longitude)
  end

  def build_params
    params.permit(book: %i[title author publisher synopsis published_date rating thumbnail description])
  end
end
