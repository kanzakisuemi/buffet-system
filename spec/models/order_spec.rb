require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#presence' do
    it 'of code - autogenerates' do
      order = Order.new(code: nil)

      order.valid?
      result = order.errors.include?(:code)

      expect(result).to be false
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
  describe '#comparison' do
    it 'due date should be less than event date' do
      kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
      buffet = Buffet.create!(
        social_name: 'Buffet da Maria',
        corporate_name: 'Buffet da Maria LTDA',
        company_registration_number: CNPJ.generate,
        phone: '996348000',
        email: 'maria@email.com',
        address: 'Rua das Flores, 230',
        neighborhood: 'Jardim das Flores',
        city: 'São Paulo',
        state: 'SP',
        zip_code: '12345689',
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
      result = order.errors.include?(:event_date)

      expect(result).to be true
    end
    it 'due date should be greater than or equal to today' do
      order = Order.new(due_date: 1.day.ago)

      order.valid?
      result = order.errors.include?(:due_date)

      expect(result).to be true
    end
  end
  describe '#numericality' do
    it 'guest estimation should be less or equal to event capacity' do
      kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
      buffet = Buffet.create!(
        social_name: 'Buffet da Maria',
        corporate_name: 'Buffet da Maria LTDA',
        company_registration_number: CNPJ.generate,
        phone: '996348000',
        email: 'maria@email.com',
        address: 'Rua das Flores, 230',
        neighborhood: 'Jardim das Flores',
        city: 'São Paulo',
        state: 'SP',
        zip_code: '12345678',
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
  end
  describe '#event_date_available?' do
    it 'does not exceed max number of events this buffet supports' do
      kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
      kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
      buffet = Buffet.create!(
        social_name: 'Buffet da Maria',
        corporate_name: 'Buffet da Maria LTDA',
        company_registration_number: CNPJ.generate,
        events_per_day: 2,
        phone: '996348000',
        email: 'maria@email.com',
        address: 'Rua das Flores, 230',
        neighborhood: 'Jardim das Flores',
        city: 'São Paulo',
        state: 'SP',
        zip_code: '12345678',
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
      Order.create!(
        event_date: 12.days.from_now,
        guests_estimation: 45,
        event_details: 'Festa de aniversário de 5 anos da Maria',
        event_address: nil,
        event_type_id: event_type.id,
        user: kendall,
        status: 2
      )

      order = Order.new(
        event_date: 12.days.from_now,
        guests_estimation: 40,
        event_details: 'Festa de aniversário de 2 anos do José',
        event_address: nil,
        event_type_id: event_type.id,
        user: kendall,
        status: 0
      )

      order.valid?
      result = order.errors.include?(:event_date)

      expect(result).to be false
    end
    it 'exceeds max number of events this buffet supports - when events per day is not set (default is 1)' do
      kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
      kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
      buffet = Buffet.create!(
        social_name: 'Buffet da Maria',
        corporate_name: 'Buffet da Maria LTDA',
        company_registration_number: CNPJ.generate,
        phone: '996348000',
        email: 'maria@email.com',
        address: 'Rua das Flores, 230',
        neighborhood: 'Jardim das Flores',
        city: 'São Paulo',
        state: 'SP',
        zip_code: '12345678',
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
      Order.create!(
        event_date: 12.days.from_now,
        guests_estimation: 45,
        event_details: 'Festa de aniversário de 5 anos da Maria',
        event_address: nil,
        event_type_id: event_type.id,
        user: kendall,
        status: 2
      )

      order = Order.new(
        event_date: 12.days.from_now,
        guests_estimation: 40,
        event_details: 'Festa de aniversário de 2 anos do José',
        event_address: nil,
        event_type_id: event_type.id,
        user: kendall,
        status: 0
      )

      order.valid?
      result = order.errors.include?(:event_date)

      expect(result).to be true
    end
    it 'exceeds max number of events this buffet supports - when events per day is set by business owner (3)' do
      kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
      kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
      buffet = Buffet.create!(
        social_name: 'Buffet da Maria',
        corporate_name: 'Buffet da Maria LTDA',
        company_registration_number: CNPJ.generate,
        events_per_day: 3,
        phone: '996348000',
        email: 'maria@email.com',
        address: 'Rua das Flores, 230',
        neighborhood: 'Jardim das Flores',
        city: 'São Paulo',
        state: 'SP',
        zip_code: '12345678',
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
      Order.create!(
        event_date: 12.days.from_now,
        guests_estimation: 50,
        event_details: 'Festa de aniversário de 10 anos da Josefa',
        event_address: nil,
        event_type_id: event_type.id,
        user: kendall,
        status: 2
      )
      Order.create!(
        event_date: 12.days.from_now,
        guests_estimation: 45,
        event_details: 'Festa de aniversário de 5 anos da Maria',
        event_address: nil,
        event_type_id: event_type.id,
        user: kendall,
        status: 2
      )
      Order.create!(
        event_date: 12.days.from_now,
        guests_estimation: 60,
        event_details: 'Festa de aniversário de 8 anos do Lucas',
        event_address: nil,
        event_type_id: event_type.id,
        user: kendall,
        status: 2
      )
      order = Order.new(
        event_date: 12.days.from_now,
        guests_estimation: 35,
        event_details: 'Festa de aniversário de 2 anos do José',
        event_address: nil,
        event_type_id: event_type.id,
        user: kendall,
        status: 0
      )

      order.valid?
      result = order.errors.include?(:event_date)

      expect(result).to be true
    end
  end
  describe '#total_price' do
    it 'charges extra fee' do
      kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
      kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
      buffet = Buffet.create!(
        social_name: 'Buffet da Maria',
        corporate_name: 'Buffet da Maria LTDA',
        company_registration_number: CNPJ.generate,
        events_per_day: 3,
        phone: '996348000',
        email: 'maria@email.com',
        address: 'Rua das Flores, 230',
        neighborhood: 'Jardim das Flores',
        city: 'São Paulo',
        state: 'SP',
        zip_code: '12345678',
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
      order = Order.new(
        event_date: 12.days.from_now,
        guests_estimation: 35,
        event_details: 'Festa de aniversário de 2 anos do José',
        event_address: nil,
        event_type_id: event_type.id,
        user: kendall,
        status: 0,
        charge_fee: true,
        extra_fee: 100.00,
        grant_discount: false,
        discount: 0.00
      )

      result = order.total_price.to_f

      if order.event_date.on_weekend?
        expect(result).to eq(1600.00)
      else
        expect(result).to eq(1350.00)
      end
    end
    it 'grants discount' do
      kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
      kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
      buffet = Buffet.create!(
        social_name: 'Buffet da Maria',
        corporate_name: 'Buffet da Maria LTDA',
        company_registration_number: CNPJ.generate,
        events_per_day: 3,
        phone: '996348000',
        email: 'maria@email.com',
        address: 'Rua das Flores, 230',
        neighborhood: 'Jardim das Flores',
        city: 'São Paulo',
        state: 'SP',
        zip_code: '12345678',
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
      order = Order.new(
        event_date: 12.days.from_now,
        guests_estimation: 35,
        event_details: 'Festa de aniversário de 2 anos do José',
        event_address: nil,
        event_type_id: event_type.id,
        user: kendall,
        status: 0,
        charge_fee: false,
        extra_fee: 0.00,
        grant_discount: true,
        discount: 50.00
      )

      result = order.total_price.to_f

      if order.event_date.on_weekend?
        expect(result).to eq(1450.00)
      else
        expect(result).to eq(1200.00)
      end
    end
    it 'charges extra fee and grants discount' do
      kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
      kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
      buffet = Buffet.create!(
        social_name: 'Buffet da Maria',
        corporate_name: 'Buffet da Maria LTDA',
        company_registration_number: CNPJ.generate,
        events_per_day: 3,
        phone: '996348000',
        email: 'maria@email.com',
        address: 'Rua das Flores, 230',
        neighborhood: 'Jardim das Flores',
        city: 'São Paulo',
        state: 'SP',
        zip_code: '12345678',
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
      order = Order.new(
        event_date: 12.days.from_now,
        guests_estimation: 35,
        event_details: 'Festa de aniversário de 2 anos do José',
        event_address: nil,
        event_type_id: event_type.id,
        user: kendall,
        status: 0,
        charge_fee: true,
        extra_fee: 200.00,
        grant_discount: true,
        discount: 100.00
      )

      result = order.total_price.to_f

      if order.event_date.on_weekend?
        expect(result).to eq(1600.00)
      else
        expect(result).to eq(1350.00)
      end
    end
  end
  describe '#event_price' do
    context 'weekday' do
      it 'returns event price based on base price and fees' do
        kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
        kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
        buffet = Buffet.create!(
          social_name: 'Buffet da Maria',
          corporate_name: 'Buffet da Maria LTDA',
          company_registration_number: CNPJ.generate,
          events_per_day: 3,
          phone: '996348000',
          email: 'maria@email.com',
          address: 'Rua das Flores, 230',
          neighborhood: 'Jardim das Flores',
          city: 'São Paulo',
          state: 'SP',
          zip_code: '12345678',
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
        order = Order.new(
          event_date: weekday_date,
          guests_estimation: 35,
          event_details: 'Festa de aniversário de 2 anos do José',
          event_address: nil,
          event_type_id: event_type.id,
          user: kendall,
          status: 0
        )

        result = order.event_price.to_f

        expect(result).to eq(1250.00)
      end
    end
    context 'weekend' do
      it 'returns event price based on base price and fees' do
        kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
        kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
        buffet = Buffet.create!(
          social_name: 'Buffet da Maria',
          corporate_name: 'Buffet da Maria LTDA',
          company_registration_number: CNPJ.generate,
          events_per_day: 3,
          phone: '996348000',
          email: 'maria@email.com',
          address: 'Rua das Flores, 230',
          neighborhood: 'Jardim das Flores',
          city: 'São Paulo',
          state: 'SP',
          zip_code: '12345678',
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
        order = Order.new(
          event_date: weekend_date,
          guests_estimation: 35,
          event_details: 'Festa de aniversário de 2 anos do José',
          event_address: nil,
          event_type_id: event_type.id,
          user: kendall,
          status: 0
        )

        result = order.event_price.to_f

        expect(result).to eq(1500.00)
      end
    end
  end
  describe '#payment_methods_options_for_select' do
    it 'returns payment methods options for select' do
      pix = PaymentMethod.create!(name: 'Pix')
      credit_card = PaymentMethod.create!(name: 'Cartão de Crédito')
      debit_card = PaymentMethod.create!(name: 'Cartão de Débito')
      kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
      kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
      buffet = Buffet.create!(
        social_name: 'Buffet da Maria',
        corporate_name: 'Buffet da Maria LTDA',
        company_registration_number: CNPJ.generate,
        events_per_day: 3,
        phone: '996348000',
        email: 'maria@email.com',
        address: 'Rua das Flores, 230',
        neighborhood: 'Jardim das Flores',
        city: 'São Paulo',
        state: 'SP',
        zip_code: '12345678',
        description: 'Buffet para festas infantis e de adultos',
        user: kylie,
        payment_methods: [ pix, credit_card, debit_card ]
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
      order = Order.new(
        event_date: 12.days.from_now,
        guests_estimation: 35,
        event_details: 'Festa de aniversário de 2 anos do José',
        event_address: nil,
        event_type_id: event_type.id,
        user: kendall,
        status: 0,
        charge_fee: true,
        extra_fee: 100.00,
        grant_discount: false,
        discount: 0.00
      )

      result = order.payment_methods_options_for_select

      expect(result).to eq([['Pix', pix.id], ['Cartão de Crédito', credit_card.id], ['Cartão de Débito', debit_card.id]])
    end
  end
  describe '#humanized_status' do
    it 'returns humanized status' do
      order = Order.new(status: 2)

      result = order.humanized_status

      expect(result).to eq('Confirmado')
    end
  end
  describe '#code_and_date' do
    it 'returns code and date' do
      allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
      order = Order.new(event_date: 12.days.from_now)
      order.valid?

      result = order.code_and_date

      expect(result).to eq('ABC12345 - ' + 12.days.from_now.strftime('%d/%m/%Y'))
    end
  end
end
