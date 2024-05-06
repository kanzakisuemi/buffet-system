require 'rails_helper'

describe 'business owner deletes' do
  it 'one picture from event type w/ two pictures' do
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
      buffet: kylie.buffet,
      base_price: 1000.00,
      weekend_fee: 20,
      per_person_fee: 50.00,
      per_person_weekend_fee: 20,
      per_hour_fee: 100.00,
      per_hour_weekend_fee: 50
    )
    login_as(kylie)
    visit root_path

    within('nav') do
      click_on 'Buffets'
      click_on 'Ver meu Buffet'
    end

    click_on 'Configurar Eventos'
    click_on 'Festa Infantil'
    click_on 'Editar'
    attach_file 'Fotos', [Rails.root.join('spec', 'files', 'kevin_malone.jpg'), Rails.root.join('spec', 'files', 'michael_scott.jpg')]
    click_on 'Salvar'
    click_on 'Editar'

    within('div#attachment_1') do
      click_on 'Remover'
    end

    expect(page).not_to have_css('img[src*="michal_scott.jpg"]')
    expect(page).to have_css('img[src*="kevin_malone.jpg"]')
  end
end

