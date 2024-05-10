require 'rails_helper'

describe 'user tries to access' do
  it 'order details and succeds - as client' do
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
      zip_code: '123456',
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
    order = Order.create!(
      event_date: 12.days.from_now,
      guests_estimation: 45,
      event_details: 'Festa de aniversário de 5 anos da Maria',
      event_address: nil,
      event_type_id: event_type.id,
      user: kendall,
      status: 0
    )

    login_as(kendall)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code_and_date

    expect(page).to have_content(order.code)
    expect(page).to have_content(order.buffet.social_name)
    expect(page).to have_content(order.event_type.name)
    expect(page).to have_content(order.event_details)
    expect(page).to have_content(order.event_date.strftime('%d/%m/%Y'))
    expect(page).to have_content(order.guests_estimation)
    expect(page).to have_content(order.user.name)
    expect(page).to have_content(order.humanized_status)
  end
  it 'order details and sees a warning for orders with same date - as business owner' do
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
      zip_code: '123456',
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
      event_date: 12.days.from_now,
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
    click_on order_1.code_and_date

    expect(page).to have_content('Existe outro evento marcado para a mesma data. Confira: ')
    expect(page).to have_link(href: order_path(order_2))
  end
end
