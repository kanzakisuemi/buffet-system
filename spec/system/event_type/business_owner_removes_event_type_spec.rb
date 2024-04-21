require 'rails_helper'

describe 'business owner removes a event type' do

  let(:kylie) { User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0) }
  let(:buffet) { 
    Buffet.create!(
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
  }
  let(:event_type) { 
    EventType.create!(
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
  }

  it 'successfully' do
    buffet
    event_type
    login_as(kylie)
    visit root_path

    within('nav') do
      click_on 'Buffets'
      click_on 'Ver meu Buffet'
    end

    click_on 'Configurar Eventos'
    click_on 'Festa Infantil'
    click_on 'Remover'

    expect(page).to have_content('Não existem tipos de evento cadastrados para este buffet.')
  end
end
