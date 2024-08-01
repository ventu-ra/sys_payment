require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should create transaction and return approved status" do
    post transactions_url, params: { transaction: { card_number: "4532015112830366", amount: 1000, currency: "USD" } }, as: :json
    assert_response :created
    json_response = JSON.parse(@response.body)
    assert_equal "approved", json_response["status"]
    assert_equal "Transaction approved", json_response["message"]
  end

  test "should create transaction and return declined status" do
    post transactions_url, params: { transaction: { card_number: "1234567812345670", amount: 1000, currency: "USD" } }, as: :json
    assert_response :unprocessable_entity
    json_response = JSON.parse(@response.body)
    assert_equal "declined", json_response["status"]
    assert_equal "Invalid transaction declined", json_response["message"]
  end
end
