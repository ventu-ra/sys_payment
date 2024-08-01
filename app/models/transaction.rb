require "credit_card_validations"

class Transaction < ApplicationRecord
  before_create :process

  VALID_CURRENCIES = ['USD', 'EUR', 'BRL']

  def process
    if valid_card_number?(card_number) && valid_amount?(amount) && valid_currency?(currency)
      self.status = 'approved'
      self.message = 'Transaction approved'
    else
      self.status = 'declined'
      self.message = 'Invalid transaction declined'
    end
  end

  private

  def valid_card_number?(card_number)
    return true if CreditCardValidations::Luhn.valid?(card_number) && valid_card_issuer?(card_number)

    self.message = 'Invalid credit card number'
    false
  end

  def valid_card_issuer?(card_number)
    issuers = {
      "visa" => /^4[0-9]{12}(?:[0-9]{3})?$/,
      "mastercard" => /^(?:5[1-5][0-9]{14})$/,
      "discover" => /^6(?:011|5[0-9]{2})[0-9]{12}$/
      # Adicione outros emissores conforme necessário
    }
    issuers.any? { |_, pattern| pattern.match?(card_number) }
  end

  def valid_amount?(amount)
    return true if amount.is_a?(Numeric) && amount > 0

    self.message = 'Invalid transaction amount'
    false
  end

  def valid_currency?(currency)
    return true if VALID_CURRENCIES.include?(currency)

    self.message = 'Invalid currency'
    false
  end
end
