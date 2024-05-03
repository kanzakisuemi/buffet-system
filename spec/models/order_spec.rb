require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#presence' do
    it 'of code - autogenerates' do
      order = Order.new(code: nil)

      order.valid?
      result = order.errors.include?(:code)

      expect(result).to be false
    end
    it 'of user' do
      order = Order.new(user: nil)

      order.valid?
      result = order.errors.include?(:user)

      expect(result).to be true
    end
    it 'of event type' do
      order = Order.new(event_type: nil)

      order.valid?
      result = order.errors.include?(:event_type)

      expect(result).to be true
    end
    it 'of event date' do
      order = Order.new(event_date: nil)

      order.valid?
      result = order.errors.include?(:event_date)

      expect(result).to be true
    end
    it 'of guests estimation' do
      order = Order.new(guests_estimation: nil)

      order.valid?
      result = order.errors.include?(:guests_estimation)

      expect(result).to be true
    end
  end
end
