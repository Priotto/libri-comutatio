class ReviewsController < ApplicationController
  def create
    @transaction = Trade.find(params[:trade_id])
    receiver = current_user
    sender = @transaction.seller == current_user ? @transaction.buyer : @transaction.seller
    @review = Review.new(review_params)
    @review.sender = sender
    @review.receiver = receiver
    @review.trade = @transaction

    if @review.save
      flash[:notice] = "Your review was sent!"
      redirect_to root_path
    else
      render 'trades/index', status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:sender_id, :receiver_id, :score)
  end
end
