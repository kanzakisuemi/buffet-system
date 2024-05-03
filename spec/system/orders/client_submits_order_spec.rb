require 'rails_helper'

describe 'user tries to submit an order' do
  it 'and buffet has no event types registered - as client' do
    kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
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
      user: kylie
    )

    login_as(kendall)
    visit root_path

    click_on 'Buffets'
    click_on 'Buffet da Maria'
    click_on 'Contratar Buffet'

    expect(current_path).to eq(buffet_path(buffet))
    expect(page).to have_content('Este Buffet ainda não possui nenhum evento cadastrado')
  end
  it 'and succeds - as client' do
    kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
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
      buffet: kylie.buffet
    )

    login_as(kendall)
    visit root_path

    click_on 'Buffets'
    click_on 'Buffet da Maria'
    click_on 'Contratar Buffet'

    click_on 'Festa Infantil'
    fill_in 'Data do Evento', with: 10.days.from_now
    fill_in 'Quantidade de Convidados', with: 50
    expect(page).not_to have_content('event_address')
    click_on 'Agendar Evento'

    expect(current_path).to eq(order_path(Order.last))
    expect(page).to have_content('Festa Infantil')
    expect(page).to have_content(10.days.from_now.strftime('%d/%m/%Y'))
    expect(page).to have_content('50')

  end
  it 'and must be authenticated - as visitor' do
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
      buffet: kylie.buffet
    )

    visit root_path

    click_on 'Buffets'
    click_on 'Buffet da Maria'
    click_on 'Contratar Buffet'
    click_on 'Festa Infantil'

    expect(current_path).to eq(new_user_session_path)
  end
end