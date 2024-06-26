require 'rails_helper'

describe 'user sees only unarchived event types' do
  it 'successfully - as visitor' do
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
      base_price: 4000.0,
      weekend_fee: 25,
      per_person_fee: 50.0,
      per_person_weekend_fee: 10,
      per_hour_fee: 300.0,
      per_hour_weekend_fee: 10,
      buffet: kylie.buffet
    )
    event_type = EventType.create!(
      category: 3,
      name: 'Festa de 15 anos',
      description: 'Festa para debutantes',
      default_duration_minutes: 240,
      minimal_people_capacity: 100,
      maximal_people_capacity: 200,
      food_menu: 'Bolo, doces, salgados, refrigerante e suco',
      alcoholic_drinks: true,
      parking_service: true,
      base_price: 4000.0,
      weekend_fee: 25,
      per_person_fee: 50.0,
      per_person_weekend_fee: 10,
      per_hour_fee: 300.0,
      per_hour_weekend_fee: 10,
      buffet: kylie.buffet,
      archived: true
    )

    visit root_path

    within('nav') do
      click_on 'Buffets'
    end

    click_on 'Buffet da Maria'
    click_on 'Ver Tipos de Eventos'

    expect(page).to have_content('Festa Infantil')
    expect(page).not_to have_content('Festa de 15 anos')
  end
end
