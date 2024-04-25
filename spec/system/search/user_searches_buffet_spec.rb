require 'rails_helper'

describe 'user searches' do
  let(:kylie) { User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0) }
  let(:buffet_kylie) { 
    Buffet.create!(
      social_name: 'Buffet da Kylie',
      corporate_name: 'Buffet da Kylie LTDA',
      company_registration_number: '12345678910111',
      phone: '996348000',
      email: 'support@khybuffet.com',
      address: 'Rua das Flores, 230',
      neighborhood: 'Jardim das Flores',
      city: 'São Paulo',
      state: 'SP',
      zip_code: '123456',
      description: 'Buffet para festas infantis e de adultos',
      user: kylie
    ) 
  }
  let(:kendall) { User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 0) }
  let(:buffet_kendall) { 
    Buffet.create!(
      social_name: 'Buffet da Kendall',
      corporate_name: 'Buffet da Kendall LTDA',
      company_registration_number: '12345678978009',
      phone: '996345000',
      email: 'support@buffetkendall.com',
      address: 'Rua dos Cactos, 780',
      neighborhood: 'Jardim dos Cactos',
      city: 'São Paulo',
      state: 'SP',
      zip_code: '123407',
      description: 'Buffet para festas de cavalos',
      user: kendall
    ) 
  }
  let(:julia) { User.create!(name: 'Julia Suemi Kanzaki', email: 'ju@kanzaki.com', password: 'password123', role: 0) }
  let(:buffet_julia) { 
    Buffet.create!(
      social_name: 'As Festas da Ju',
      corporate_name: 'As Festas da Ju LTDA',
      company_registration_number: '18975600978008',
      phone: '996347600',
      email: 'support@kanzaki.com',
      address: 'Rua dos Morros, 450',
      neighborhood: 'Jardim dos Morros',
      city: 'São Paulo',
      state: 'SP',
      zip_code: '458901',
      description: 'Buffet para as melhores festas do mundo!',
      user: julia
    ) 
  }
  let(:event_type) { 
    EventType.create!(
      category: 1,
      name: 'Formatura de Faculdade',
      description: 'Festa de formatura para turmas de universidades.',
      default_duration_minutes: 300,
      minimal_people_capacity: 200,
      maximal_people_capacity: 300,
      food_menu: 'Entrada: Salgadinhos e docinhos. Prato principal: Buffet de massas. Sobremesa: Bolo de chocolate e sorvete.',
      alcoholic_drinks: true,
      parking_service: true,
      decoration: true,
      buffet: kylie.buffet
    )
  }
  it 'for buffets name - as visitor' do
    buffet_kylie
    buffet_kendall

    visit root_path
    within('nav') do
      fill_in 'Pesquisar Buffet', with: 'Buffet da Kendall'
      click_on 'Pesquisar'
    end

    within('div#search-results') do
      expect(page).to have_content('Buffet da Kendall')
      expect(page).not_to have_content('Buffet da Kylie')
    end
  end
  it 'for buffets by city - as visitor' do
    buffet_kylie
    buffet_kendall

    visit root_path
    within('nav') do
      fill_in 'Pesquisar Buffet', with: 'São Paulo'
      click_on 'Pesquisar'
    end

    within('div#search-results') do
      expect(page).to have_content('Buffet da Kendall')
      expect(page).to have_content('Buffet da Kylie')
    end
  end
  it 'for buffets by event type - as visitor' do
    buffet_kylie
    buffet_kendall
    event_type

    visit root_path
    within('nav') do
      fill_in 'Pesquisar Buffet', with: 'Formatura'
      click_on 'Pesquisar'
    end

    within('div#search-results') do
      expect(page).to have_content('Buffet da Kylie')
      expect(page).not_to have_content('Buffet da Kendall')
    end

    within('div#buffets') do
      expect(page).to have_content('Buffet da Kendall')
      expect(page).not_to have_content('Buffet da Kylie')
    end
  end
  it 'for a buffet and results are ordered - as visitor' do
    buffet_kylie
    buffet_kendall
    buffet_julia
      
    visit root_path
    within('nav') do
      fill_in 'Pesquisar Buffet', with: 'São Paulo'
      click_on 'Pesquisar'
    end
  
      within('div#search-results') do
        expect(page).to have_content('As Festas da Ju')
        expect(page).to have_content('Buffet da Kendall')
        expect(page).to have_content('Buffet da Kylie')
      end
  end
end
