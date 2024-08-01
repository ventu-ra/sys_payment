class PaymentGateway
  def initialize
    @transactions = []
  end

  def process_transaction(card_number, amount, currency)
    transaction = Transaction.new(card_number: card_number, amount: amount, currency: currency)
    transaction.process

    if transaction.save
      @transactions << transaction
      { status: transaction.status, message: transaction.message }
    else
      { status: 'error', message: transaction.errors.full_messages.join(', ') }
    end
  end
end
