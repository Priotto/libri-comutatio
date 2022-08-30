class TradesController < ApplicationController

  def index
    @transactions = Trade.where(seller: current_user).where(accepted: false)
    @history_transactions = Trade.where("seller_id = ? OR buyer_id = ?", current_user, current_user).where("accepted = ?", true)
  end

  def create
    @books = Book.available.where(user: current_user).order(:title)
    # É necessário informar qual offer está sendo criada para uma transaction
    @book = Book.find(params[:book_id])
    # Com o ID da offer, sabe-se quem é o user(seller)
    seller = @book.user
    # O current user será outro usuário logado. O valor de current_user vem de devise
    buyer = current_user
    @transaction = Trade.new(transaction_params)
    # Atribui-se seller e buyer a transaction
    @transaction.seller = seller
    @transaction.buyer = buyer
    # Na transaction deve constar o card que está sendo "vendido".
    @transaction.seller_book = @book
    chat = Chatroom.create!
    # Por default a transação não foi aceita: Accepted é false.
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
    # No need for app/views/restaurants/update.html.erb
    redirect_to transactions_path
  end

  def destroy
    @transaction = Trade.find(params[:id])
    @transaction.destroy
    redirect_to transactions_path, status: :see_other
  end

  private

  def transaction_params
    params.require(:transaction).permit(:buyer_book_id, :seller_book_id, :accepted)
  end
end
