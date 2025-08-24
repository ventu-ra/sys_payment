require "test_helper"
require_relative "../app/models/transaction" # ajuste o path conforme seu projeto

class TransactionTest < Minitest::Test
  def setup
    @valid_card = "5555556355564617" # Mastercard válido
  end

  def test_transacao_valida
    transaction = Transaction.new(
      card_number: @valid_card,
      amount: 100,
      currency: "BRL"
    )
    transaction.process
    assert_equal "approved", transaction.status
    assert_equal "Transaction approved", transaction.message
  end

  def test_cartao_invalido
    transaction = Transaction.new(
      card_number: "1234567890123456",
      amount: 100,
      currency: "BRL"
    )
    transaction.process
    assert_equal "declined", transaction.status
    assert_includes transaction.message, "Invalid credit card number"
  end

  def test_valor_negativo
    transaction = Transaction.new(
      card_number: @valid_card,
      amount: -50,
      currency: "BRL"
    )
    transaction.process
    assert_equal "declined", transaction.status
    assert_includes transaction.message, "Invalid transaction amount"
  end

  def test_moeda_invalida
    transaction = Transaction.new(
      card_number: @valid_card,
      amount: 100,
      currency: "JPY"
    )
    transaction.process
    assert_equal "declined", transaction.status
    assert_includes transaction.message, "Invalid currency"
  end

  def test_multiplos_erros
    transaction = Transaction.new(
      card_number: "1234567890123456",
      amount: -10,
      currency: "JPY"
    )
    transaction.process
    assert_equal "declined", transaction.status
    assert_includes transaction.message, "Invalid credit card number"
    assert_includes transaction.message, "Invalid transaction amount"
    assert_includes transaction.message, "Invalid currency"
  end
end
