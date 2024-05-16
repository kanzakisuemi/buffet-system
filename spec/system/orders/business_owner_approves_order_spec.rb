require 'rails_helper'

describe 'business owner evaluates order' do
  it 'and approves' do
    kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
    debit = PaymentMethod.create!(name: 'Cartão de Débito')
    credit = PaymentMethod.create!(name: 'Cartão de Crédito')
    pix = PaymentMethod.create!(name: 'Pix')
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
      status: 0
    )

    login_as(kylie)
    visit root_path
    click_on 'Pedidos'
    click_on 'Todos Pedidos'
    click_on order.code_and_date

    expect(page).to have_content 'Pendente'
    click_on 'Aprovar Evento'
    select 'Pix', from: 'Método de Pagamento'
    check 'Cobrar Taxa Extra'
    fill_in 'Taxa Extra', with: 100
    fill_in 'Detalhes do Orçamento', with: 'Taxa extra de 100 reais para cobrir deslocamento.'
    fill_in 'Data de Vencimento', with: 5.day.from_now
    
    click_on 'Aprovar Evento'

    expect(page).to have_content('Pedido atualizado com sucesso!')
    expect(page).to have_content('Taxa Extra: R$100')
    expect(page).not_to have_content('Desconto: R$')
    expect(page).to have_content('Detalhes do Orçamento: Taxa extra de 100 reais para cobrir deslocamento.')
    expect(page).to have_content('Data de Vencimento:')
    expect(page).to have_content(5.days.from_now.strftime('%d/%m/%Y'))
    if 12.days.from_now.on_weekday?
    expect(page).to have_content('Orçamento: R$1750.0')
    elsif 12.days.from_now.on_weekend?
      expect(page).to have_content('Orçamento: R$2100.0')
    end
    expect(page).to have_content('Aprovado')
  end
  it 'and fails to approve' do
    kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
    debit = PaymentMethod.create!(name: 'Cartão de Débito')
    credit = PaymentMethod.create!(name: 'Cartão de Crédito')
    pix = PaymentMethod.create!(name: 'Pix')
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
      status: 0
    )

    login_as(kylie)
    visit root_path
    click_on 'Pedidos'
    click_on 'Todos Pedidos'
    click_on order.code_and_date

    expect(page).to have_content 'Pendente'
    click_on 'Aprovar Evento'
    select 'Pix', from: 'Método de Pagamento'
    check 'Cobrar Taxa Extra'
    fill_in 'Taxa Extra', with: 100.00
    fill_in 'Detalhes do Orçamento', with: 'Taxa extra de 100 reais para cobrir deslocamento.'
    fill_in 'Data de Vencimento', with: 20.days.from_now
    
    click_on 'Aprovar Evento'
    
    expect(page).to have_content('a')
  end
  it 'and rejects' do
    kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
    debit = PaymentMethod.create!(name: 'Cartão de Débito')
    credit = PaymentMethod.create!(name: 'Cartão de Crédito')
    pix = PaymentMethod.create!(name: 'Pix')
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
      status: 0
    )

    login_as(kylie)
    visit root_path
    click_on 'Pedidos'
    click_on 'Todos Pedidos'
    click_on order.code_and_date

    click_on 'Pendente'
    click_on 'Cancelar Evento'

    expect(page).to have_content('Pedido cancelado!')
    expect(page).to have_content('Cancelado')
  end
end
