class BooksController < ApplicationController
  def index
    if params[:query].present?
      @books = Book.search_books(params[:query])
    else
      @books = Book.available
    end
  end

  def show
    @book = Book.find(params[:id])
    @transaction = Trade.new
    @books = Book.available.where(user: current_user).order(:title)
  end

  def new
    @book = Book.new
  end

  def autocomplete
    @books = Book.get_book_attributes(params[:q])
    unless @books.empty?
      render partial: "book", formats: :html
    end
  end

  def build #foi adicionado um parâmetro(book)
    # book.update(build_params[:book])
    # book.user = current_user
    @book = Book.new(build_params[:book])
    @book.user = current_user
    if @book.save
      flash[:notice] = "Livro adicionado!"
      redirect_to edit_book_path(@book)
    end
  end

  def create
    @book = Book.find(book_params_edit)
    @book.description = book_params_edit[:description]
    raise
    if @book.update(book_params_edit)
      redirect_to book_path(@book)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params_edit)
      redirect_to book_path(@book)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, status: :see_other
  end

  def my
    @books = current_user.books
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


  # def build_params
  #   params.require(:book).permit(book: [:title, :author, :publisher, :synopsis, :published_date, :thumbnail])
  # end

end
