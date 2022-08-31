class TradesController < ApplicationController

  def index
    @transactions = Trade.where("seller_id = ? OR buyer_id = ?", current_user, current_user).where(accepted: false)
    @history_transactions = Trade.where("seller_id = ? OR buyer_id = ?", current_user, current_user).where("accepted = ?", true)
  end

  def create
    @books = Book.available.where(user: current_user).order(:title)
    @book = Book.find(params[:book_id])
    seller = @book.user
    buyer = current_user
    @transaction = Trade.new(transaction_params)
    @transaction.seller = seller
    @transaction.buyer = buyer
    @transaction.seller_book = @book
    chat = Chatroom.new
    chat.name = "#{@book.title}"
    chat.save
    @transaction.chatroom = chat

    if @transaction.save
      flash[:notice] = "Trade request sent!"
      redirect_to chatroom_path(chat)
    else
      render 'books/show', status: :unprocessable_entity
    end
  end

  def update
    @transaction = Trade.find(params[:id])
    @transaction.accepted = true
    seller_book = Book.find(@transaction.seller_book.id)
    seller_book.update(user: @transaction.buyer)
    buyer_book = Book.find(@transaction.buyer_book.id)
    buyer_book.update(user: current_user)
    seller_book.trade!
    buyer_book.trade!
    @transaction.save!
    redirect_to trades_path
  end

  def destroy
    @transaction = Trade.find(params[:id])
    @transaction.destroy
    redirect_to trades_path, status: :see_other
  end

  private

  def transaction_params
    params.require(:trade).permit(:buyer_book_id, :seller_book_id, :accepted)
  end
end
