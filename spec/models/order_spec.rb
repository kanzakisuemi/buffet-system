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
  describe '#validates' do
    it 'guest estimation should be less or equal to event capacity' do
      kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
      buffet = Buffet.create!(
        social_name: 'Buffet da Maria',
        corporate_name: 'Buffet da Maria LTDA',
        company_registration_number: '12345678910111',
        phone: '996348000',
        email: 'maria@email.com',
        address: 'Rua das Flores, 230',
        neighborhood: 'Jardim das Flores',
        city: 'São Paulo',
        state: 'SP',
        zip_code: '123456',
        description: 'Buffet para festas infantis e de adultos',
        user: kylie,
        payment_methods: []
      )
      event_type = EventType.create!(
        category: 3,
        name: 'Festa Infantil',
        description: 'Festa para crianças',
        default_duration_minutes: 240,
        minimal_people_capacity: 30,
        maximal_people_capacity: 60,
        food_menu: 'Bolo, doces, salgados, refrigerante e suco',
        alcoholic_drinks: true,
        parking_service: true,
        buffet: kylie.buffet,
        base_price: 1000.00,
        weekend_fee: 20,
        per_person_fee: 50.00,
        per_person_weekend_fee: 20,
        per_hour_fee: 100.00,
        per_hour_weekend_fee: 50
      )
      order = Order.new(guests_estimation: 70, event_type: event_type)

      order.valid?
      result = order.errors.include?(:guests_estimation)

      expect(result).to be true
    end
    it 'due date should be less than event date' do
      kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
      buffet = Buffet.create!(
        social_name: 'Buffet da Maria',
        corporate_name: 'Buffet da Maria LTDA',
        company_registration_number: '12345678910111',
        phone: '996348000',
        email: 'maria@email.com',
        address: 'Rua das Flores, 230',
        neighborhood: 'Jardim das Flores',
        city: 'São Paulo',
        state: 'SP',
        zip_code: '123456',
        description: 'Buffet para festas infantis e de adultos',
        user: kylie,
        payment_methods: []
      )
      event_type = EventType.create!(
        category: 3,
        name: 'Festa Infantil',
        description: 'Festa para crianças',
        default_duration_minutes: 240,
        minimal_people_capacity: 30,
        maximal_people_capacity: 60,
        food_menu: 'Bolo, doces, salgados, refrigerante e suco',
        alcoholic_drinks: true,
        parking_service: true,
        buffet: kylie.buffet,
        base_price: 1000.00,
        weekend_fee: 20,
        per_person_fee: 50.00,
        per_person_weekend_fee: 20,
        per_hour_fee: 100.00,
        per_hour_weekend_fee: 50
      )

      order = Order.new(due_date: 5.days.from_now, event_date: 4.days.from_now, event_type: event_type)

      order.valid?
      result = order.errors.include?(:due_date)

      expect(result).to be true
    end
    it 'event date must be in the future' do
      order = Order.new(event_date: 1.day.ago)

      order.valid?
      result = order.errors.include?(:user)

      expect(result).to be true
    end
  end
end
