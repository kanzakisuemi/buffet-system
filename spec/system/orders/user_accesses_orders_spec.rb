require 'rails_helper'

describe 'user tries to access' do
  it 'buffet orders and succeds - as business owner' do
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
      user: kylie
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
    order_1 = Order.create!(
      event_date: 12.days.from_now,
      guests_estimation: 45,
      event_details: 'Festa de aniversário de 5 anos da Maria',
      event_address: nil,
      event_type_id: event_type.id,
      user: kendall,
      status: 0
    )
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABC00001')
    order_2 = Order.create!(
      event_date: 20.days.from_now,
      guests_estimation: 45,
      event_details: 'Festa de aniversário de 10 anos da Clara',
      event_address: nil,
      event_type_id: event_type.id,
      user: kendall,
      status: 0
    )

    login_as(kylie)
    visit root_path

    click_on 'Pedidos'
    click_on 'Todos Pedidos'

    expect(current_path).to eq(orders_path)
    expect(page).to have_content('ABC00000')
    expect(page).to have_content(order_1.event_date.strftime('%d/%m/%Y'))
    expect(page).to have_content('ABC00001')
    expect(page).to have_content(order_1.event_date.strftime('%d/%m/%Y'))
  end
  it 'buffet orders and sees a badge on pending orders - as business owner' do
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
      user: kylie
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
    order_1 = Order.create!(
      event_date: 12.days.from_now,
      guests_estimation: 45,
      event_details: 'Festa de aniversário de 5 anos da Maria',
      event_address: nil,
      event_type_id: event_type.id,
      user: kendall,
      status: 0
    )
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABC00001')
    order_2 = Order.create!(
      event_date: 20.days.from_now,
      guests_estimation: 45,
      event_details: 'Festa de aniversário de 10 anos da Clara',
      event_address: nil,
      event_type_id: event_type.id,
      user: kendall,
      status: 1
    )

    login_as(kylie)
    visit root_path

    click_on 'Pedidos'
    click_on 'Todos Pedidos'

    expect(current_path).to eq(orders_path)
    within("a#order_#{order_1.id}") do
      expect(page).to have_content('ABC00000')
      expect(page).to have_content(order_1.event_date.strftime('%d/%m/%Y'))
      expect(page).to have_css('span.rounded-circle', text: 'Pendente')
    end
    expect(page).not_to have_link(id: "order_#{order_2.id}")
    expect(page).to have_content('ABC00001')
    expect(page).to have_content(order_1.event_date.strftime('%d/%m/%Y'))
  end
  it 'orders through navbar and fails - as visitor' do
    visit root_path
    expect(page).not_to have_link('Pedidos')
    expect(page).not_to have_link('Todos Pedidos')
    expect(page).not_to have_link('Meus Pedidos')
  end
end
