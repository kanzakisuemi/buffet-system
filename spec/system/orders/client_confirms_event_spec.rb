require 'rails_helper'

describe 'client evaluates business owners offer' do
  it 'and confirms event' do
    kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
    debit = PaymentMethod.create!(name: 'Cartão de Débito')
    credit = PaymentMethod.create!(name: 'Cartão de Crédito')
    pix = PaymentMethod.create!(name: 'Pix')
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
      payment_methods: [debit, credit, pix]
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
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABC00000')
    order = Order.create!(
      event_date: 12.days.from_now,
      guests_estimation: 45,
      event_details: 'Festa de aniversário de 5 anos da Maria',
      event_address: nil,
      event_type_id: event_type.id,
      user: kendall,
      payment_method_id: 2,
      charge_fee: true,
      grant_discount: false,
      extra_fee: 100.00,
      discount: nil,
      budget_details: 'Taxa extra de 100 reais para cobrir deslocamento.',
      due_date: 5.days.from_now,
      status: 1
    )
    
    login_as(kendall)
    visit root_path
    click_on 'Meus Pedidos'
    click_on 'Aprovado'

    click_on 'Confirmar Evento'

    expect(page).to have_content('Pedido confirmado!')
  end
  it 'and today is the due date' do
    kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
    debit = PaymentMethod.create!(name: 'Cartão de Débito')
    credit = PaymentMethod.create!(name: 'Cartão de Crédito')
    pix = PaymentMethod.create!(name: 'Pix')
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
      payment_methods: [debit, credit, pix]
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
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABC00000')
    order = Order.create!(
      event_date: 12.days.from_now,
      guests_estimation: 45,
      event_details: 'Festa de aniversário de 5 anos da Maria',
      event_address: nil,
      event_type_id: event_type.id,
      user: kendall,
      payment_method_id: 2,
      charge_fee: true,
      grant_discount: false,
      extra_fee: 100.00,
      discount: nil,
      budget_details: 'Taxa extra de 100 reais para cobrir deslocamento.',
      due_date: 1.day.ago,
      status: 1
    )
    
    login_as(kendall)
    visit root_path
    click_on 'Meus Pedidos'
    click_on 'Aprovado'

    expect(page).not_to have_content('Confirmar Evento')
    expect(page).to have_content('O prazo de confirmação deste pedido passou :(')
  end
  it 'and today is the due date' do
    kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
    debit = PaymentMethod.create!(name: 'Cartão de Débito')
    credit = PaymentMethod.create!(name: 'Cartão de Crédito')
    pix = PaymentMethod.create!(name: 'Pix')
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
      payment_methods: [debit, credit, pix]
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
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABC00000')
    order = Order.create!(
      event_date: 12.days.from_now,
      guests_estimation: 45,
      event_details: 'Festa de aniversário de 5 anos da Maria',
      event_address: nil,
      event_type_id: event_type.id,
      user: kendall,
      payment_method_id: 2,
      charge_fee: true,
      grant_discount: false,
      extra_fee: 100.00,
      discount: nil,
      budget_details: 'Taxa extra de 100 reais para cobrir deslocamento.',
      due_date: Time.zone.today,
      status: 1
    )
    
    login_as(kendall)
    visit root_path
    click_on 'Meus Pedidos'
    click_on 'Aprovado'

    click_on 'Confirmar Evento'

    expect(page).to have_content('Pedido confirmado!')
  end
end
