class TransactionsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @transactions = Transaction.all
    render json: @transactions
  end
  def create
    gateway = PaymentGateway.new
    result = gateway.process_transaction(transaction_params[:card_number], transaction_params[:amount], transaction_params[:currency])

    if result[:status] == 'approved'
      render json: result, status: :created
    else
      render json: result, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    #params.require(:transaction).permit(:card_number, :amount, :currency)
    params.permit(:card_number, :amount, :currency)
  end
end
