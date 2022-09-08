class ReviewsController < ApplicationController
  def create
    @transaction = Trade.find(params[:trade_id])
    receiver = current_user
    sender = @transaction.seller == current_user ? @transaction.buyer : @transaction.seller
    @review = Review.new(review_params)
    @review.sender = sender
    @review.receiver = receiver
    @review.trade = @transaction

    authorize @review

    if @review.save
      redirect_to trades_path, status: :see_other
      flash[:notice] = "Your review was sent!"
    else
      flash[:alert] = "Something went wrong!"
      render 'trades/index', status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:sender_id, :receiver_id, :score)
  end
end
