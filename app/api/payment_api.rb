module PaymentAPI
  class Base < Grape::API
    format :json

    resource :transactions do
      desc 'Create a transaction'
      params do
        requires :card_number, type: String, desc: 'Card number'
        requires :amount, type: Integer, desc: 'Amount'
        requires :currency, type: String, desc: 'Currency'
      end
      post do
        gateway = PaymentGateway.new
        result = gateway.process_transaction(params[:card_number], params[:amount], params[:currency])
        status result[:status] == 'approved' ? 201 : 422
        result
      end

      desc 'List all transactions'
      get do
        Transaction.all
      end
    end

    add_swagger_documentation
  end
end
