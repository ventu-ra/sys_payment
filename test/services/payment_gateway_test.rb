require "test_helper"

class PaymentGatewayTest < ActiveSupport::TestCase
  test "should approve a valid transaction" do
    gateway = PaymentGateway.new
    result = gateway.process_transaction("4532015112830366", 1000, "USD")
    assert_equal "approved", result[:status]
    assert_equal "Transaction approved", result[:message]
  end

  test "should decline an invalid transaction" do
    gateway = PaymentGateway.new
    result = gateway.process_transaction("1234567812345670", 1000, "USD")
    assert_equal "declined", result[:status]
    assert_equal "Invalid transaction declined", result[:message]
  end
end
