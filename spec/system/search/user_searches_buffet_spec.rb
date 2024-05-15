require 'rails_helper'

describe 'user searches' do
  it 'for buffets name - as visitor' do
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
    buffet_kylie = Buffet.create!(
      social_name: 'Buffet da Kylie',
      corporate_name: 'Buffet da Kylie LTDA',
      company_registration_number: CNPJ.generate,
      phone: '996348000',
      email: 'support@khybuffet.com',
      address: 'Rua das Flores, 230',
      neighborhood: 'Jardim das Flores',
      city: 'São Paulo',
      state: 'SP',
      zip_code: '12345678',
      description: 'Buffet para festas infantis e de adultos',
      user: kylie
    )
    kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 0)
    buffet_kendall = Buffet.create!(
      social_name: 'Buffet da Kendall',
      corporate_name: 'Buffet da Kendall LTDA',
      company_registration_number: CNPJ.generate,
      phone: '996345000',
      email: 'support@buffetkendall.com',
      address: 'Rua dos Cactos, 780',
      neighborhood: 'Jardim dos Cactos',
      city: 'São Paulo',
      state: 'SP',
      zip_code: '12345678',
      description: 'Buffet para festas de cavalos',
      user: kendall
    )

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
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
    buffet_kylie = Buffet.create!(
      social_name: 'Buffet da Kylie',
      corporate_name: 'Buffet da Kylie LTDA',
      company_registration_number: CNPJ.generate,
      phone: '996348000',
      email: 'support@khybuffet.com',
      address: 'Rua das Flores, 230',
      neighborhood: 'Jardim das Flores',
      city: 'São Paulo',
      state: 'SP',
      zip_code: '12345678',
      description: 'Buffet para festas infantis e de adultos',
      user: kylie
    )
    kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 0)
    buffet_kendall = Buffet.create!(
      social_name: 'Buffet da Kendall',
      corporate_name: 'Buffet da Kendall LTDA',
      company_registration_number: CNPJ.generate,
      phone: '996345000',
      email: 'support@buffetkendall.com',
      address: 'Rua dos Cactos, 780',
      neighborhood: 'Jardim dos Cactos',
      city: 'São Paulo',
      state: 'SP',
      zip_code: '12345678',
      description: 'Buffet para festas de cavalos',
      user: kendall
    )

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
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
    buffet_kylie = Buffet.create!(
      social_name: 'Buffet da Kylie',
      corporate_name: 'Buffet da Kylie LTDA',
      company_registration_number: CNPJ.generate,
      phone: '996348000',
      email: 'support@khybuffet.com',
      address: 'Rua das Flores, 230',
      neighborhood: 'Jardim das Flores',
      city: 'São Paulo',
      state: 'SP',
      zip_code: '12345678',
      description: 'Buffet para festas infantis e de adultos',
      user: kylie
    )
    kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 0)
    buffet_kendall = Buffet.create!(
      social_name: 'Buffet da Kendall',
      corporate_name: 'Buffet da Kendall LTDA',
      company_registration_number: CNPJ.generate,
      phone: '996345000',
      email: 'support@buffetkendall.com',
      address: 'Rua dos Cactos, 780',
      neighborhood: 'Jardim dos Cactos',
      city: 'São Paulo',
      state: 'SP',
      zip_code: '12345678',
      description: 'Buffet para festas de cavalos',
      user: kendall
    )
    event_type = EventType.create!(
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
      buffet: kylie.buffet,
      base_price: 1000.00,
      weekend_fee: 20,
      per_person_fee: 50.00,
      per_person_weekend_fee: 20,
      per_hour_fee: 100.00,
      per_hour_weekend_fee: 50
    )

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
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
    buffet_kylie = Buffet.create!(
      social_name: 'Buffet da Kylie',
      corporate_name: 'Buffet da Kylie LTDA',
      company_registration_number: CNPJ.generate,
      phone: '996348000',
      email: 'support@khybuffet.com',
      address: 'Rua das Flores, 230',
      neighborhood: 'Jardim das Flores',
      city: 'São Paulo',
      state: 'SP',
      zip_code: '12345678',
      description: 'Buffet para festas infantis e de adultos',
      user: kylie
    )
    kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 0)
    buffet_kendall = Buffet.create!(
      social_name: 'Buffet da Kendall',
      corporate_name: 'Buffet da Kendall LTDA',
      company_registration_number: CNPJ.generate,
      phone: '996345000',
      email: 'support@buffetkendall.com',
      address: 'Rua dos Cactos, 780',
      neighborhood: 'Jardim dos Cactos',
      city: 'São Paulo',
      state: 'SP',
      zip_code: '12345678',
      description: 'Buffet para festas de cavalos',
      user: kendall
    )
    julia = User.create!(name: 'Julia Suemi Kanzaki', email: 'ju@kanzaki.com', password: 'password123', role: 0)
    buffet_julia = Buffet.create!(
      social_name: 'As Festas da Ju',
      corporate_name: 'As Festas da Ju LTDA',
      company_registration_number: CNPJ.generate,
      phone: '996347600',
      email: 'support@kanzaki.com',
      address: 'Rua dos Morros, 450',
      neighborhood: 'Jardim dos Morros',
      city: 'São Paulo',
      state: 'SP',
      zip_code: '12345678',
      description: 'Buffet para as melhores festas do mundo!',
      user: julia
    )
      
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
