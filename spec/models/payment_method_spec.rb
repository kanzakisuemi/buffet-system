require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  describe '#presence' do
    it 'of name' do
      payment_method = PaymentMethod.new(name: nil)

      payment_method.valid?
      result = payment_method.errors.include?(:name)

      expect(result).to be true
    end
  end
  describe '#uniqueness' do
    it 'of name' do
      PaymentMethod.create!(name: 'Boleto')

      payment_method = PaymentMethod.new(name: 'Boleto')

      payment_method.valid?
      result = payment_method.errors.include?(:name)

      expect(result).to be true
    end
  end
end
