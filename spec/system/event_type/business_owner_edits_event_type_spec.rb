require 'rails_helper'

describe 'business owner edits a event type' do
  it 'successfully' do
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
    login_as(kylie)
    visit root_path

    within('nav') do
      click_on 'Buffets'
      click_on 'Ver meu Buffet'
    end

    click_on 'Configurar Eventos'
    click_on 'Festa Infantil'
    click_on 'Editar'

    expect(page).to have_select('Categoria', selected: 'Aniversário')
    expect(page).to have_field('Nome', with: 'Festa Infantil')
    expect(page).to have_field('Descrição', with: 'Festa para crianças')
    expect(page).to have_field('Duração Padrão', with: 240)
    expect(page).to have_field('Quantidade Mínima de Pessoas', with: 30)
    expect(page).to have_field('Quantidade Máxima de Pessoas', with: 60)
    expect(page).to have_field('Cardápio', with: 'Bolo, doces, salgados, refrigerante e suco')
    expect(page).to have_checked_field('Bebidas Alcoólicas')
    expect(page).to have_checked_field('Estacionamento/Valet')

    check 'Decoração'

    click_on 'Salvar'

    expect(page).to have_content('Festa Infantil')
    expect(page).to have_content('Categoria: Aniversário')
    expect(page).to have_content('Descrição: Festa para crianças')
    expect(page).to have_content('Duração Padrão: 240 minutos')
    expect(page).to have_content('Capacidade Mínima: 30 pessoas')
    expect(page).to have_content('Capacidade Máxima: 60 pessoas')
    expect(page).to have_content('Cardápio: Bolo, doces, salgados, refrigerante e suco')
    expect(page).to have_content('Bebidas Alcoólicas: Sim')
    expect(page).to have_content('Decoração: Sim')
    expect(page).to have_content('Estacionamento/Valet: Sim')
    expect(page).to have_content('Flexibilidade de Localização: Não')    
  end
  it 'removing mandatory fields and fails' do
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
    login_as(kylie)
    visit root_path

    within('nav') do
      click_on 'Buffets'
      click_on 'Ver meu Buffet'
    end

    click_on 'Configurar Eventos'
    click_on 'Festa Infantil'
    click_on 'Editar'

    fill_in 'Nome', with: nil

    click_on 'Salvar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end
end
