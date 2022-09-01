class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
    @transaction = Trade.find(params[:trade_id])
  end

  def create
    @transaction = Trade.find(params[:trade_id])
    receiver = current_user
    sender = @transaction.seller == current_user ? @transaction.buyer : @transaction.seller
    @review = Review.new(review_params)
    @review.sender = sender
    @review.receiver = receiver
    @review.trade = @transaction

    if @review.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:sender_id, :receiver_id, :score)
  end
end
