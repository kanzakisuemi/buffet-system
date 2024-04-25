require 'rails_helper'

describe 'user sees event types' do
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
      base_price: 4000.0,
      weekend_fee: 25,
      per_person_fee: 50.0,
      per_person_weekend_fee: 10,
      per_hour_fee: 300.0,
      per_hour_weekend_fee: 10,
      buffet: kylie.buffet
    )
  }
  it 'as visitor successfully' do
    buffet
    event_type
    visit root_path

    within('nav') do
      click_on 'Buffets'
    end

    click_on 'Buffet da Maria | São Paulo | SP'
    click_on 'Ver Tipos de Eventos'

    expect(page).to have_content('Festa Infantil')
    expect(page).to have_content('Categoria: Aniversário')
    expect(page).to have_content('Descrição: Festa para crianças')
    expect(page).to have_content('Duração Padrão: 240 minutos')
    expect(page).to have_content('Capacidade Mínima: 30 pessoas')
    expect(page).to have_content('Capacidade Máxima: 60 pessoas')
    expect(page).to have_content('Cardápio: Bolo, doces, salgados, refrigerante e suco')
    expect(page).to have_content('Bebidas Alcoólicas: Sim')
    expect(page).to have_content('Decoração: Não')
    expect(page).to have_content('Estacionamento/Valet: Sim')
    expect(page).to have_content('Flexibilidade de Localização: Não')
    expect(page).to have_content('Preço Base: R$4000.0 Taxa de Final de Semana: 25%')
    expect(page).to have_content('Preço Final de Semana (taxa aplicada): R$5000.0')
    expect(page).to have_content('Preço por Pessoa Excedente: R$50.0 Taxa de Final de Semana: 10%')
    expect(page).to have_content('Preço por Pessoa Excedente no Final de Semana (taxa aplicada): R$55.0')
    expect(page).to have_content('Preço por Hora Excedente: R$300.0 Taxa de Final de Semana: 10%')
    expect(page).to have_content('Preço por Hora Excedente no Final de Semana (taxa aplicada): R$330.0')

  end
end
