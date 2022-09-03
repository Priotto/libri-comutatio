class BooksController < ApplicationController
  def index
    @books = policy_scope(Book)
    if params[:query].present?
      @books = Book.search_books(params[:query])
    else
      @books = Book.available
    end
  end

  def show
    @book = Book.find(params[:id])
    authorize @book
    @transaction = Trade.new
    @books = Book.available.where(user: current_user).order(:title)
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
      render partial: "book", formats: :html
    end
  end

  def build
    @book = Book.new(build_params[:book])
    @book.user = current_user
    authorize @book
    if @book.save
      redirect_to edit_book_path(@book)
    end
  end

  def create
    @book = Book.find(book_params_edit)
    authorize @book
    @book.description = book_params_edit[:description]
    if @book.update(book_params_edit)
      flash[:notice] = "Livro adicionado!"
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

    if @book.update(book_params_edit)
      redirect_to book_path(@book)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find(params[:id])
    authorize @book
    @book.destroy
    redirect_to books_path, status: :see_other
  end

  def my
    @books = policy_scope(Book).where(user: current_user)
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
                                 :latitude,
                                 :longitude)
  end

  def build_params
    params.permit(book: [:title, :author, :publisher, :synopsis, :published_date, :thumbnail, :description]) #foi adicionado a description
  end
end
#
