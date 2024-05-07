require 'rails_helper'

describe 'business owner starts chat with client' do
  it 'successfully' do
    kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
    debit = PaymentMethod.create!(name: 'Cartão de Débito')
    credit = PaymentMethod.create!(name: 'Cartão de Crédito')
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
      payment_methods: [debit, credit]
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
      payment_method_id: 1,
      charge_fee: true,
      grant_discount: false,
      extra_fee: 100.00,
      discount: nil,
      budget_details: 'Taxa extra de 100 reais para cobrir deslocamento.',
      due_date: 4.days.from_now,
      status: 1
    )

    login_as(kylie)
    visit root_path
    click_on 'Pedidos'
    click_on 'Todos Pedidos'
    click_on order.code_and_date
    click_on 'Iniciar Conversa com Cliente'

    fill_in 'Mensagem', with: 'Olá, tudo bem?'
    click_on 'Enviar Mensagem'

    expect(page).to have_content('Olá, tudo bem?')
    expect(page).to have_content(kylie.name)
    expect(page).to have_content(I18n.localize(Message.last.created_at, format: :short))
  end
end
