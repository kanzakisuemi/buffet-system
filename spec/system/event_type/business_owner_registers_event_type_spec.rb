require 'rails_helper'

describe 'business owner adds a event type' do
  it 'successfully' do
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
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

    login_as(kylie)
    visit root_path

    within('nav') do
      click_on 'Buffets'
      click_on 'Ver meu Buffet'
    end

    expect(current_path).to eq(buffet_path(kylie.buffet))
    click_on 'Configurar Eventos'
    click_on 'Adicionar Tipo de Evento'

    select 'Aniversário', :from => "Categoria"
    fill_in 'Nome', with: 'Festa Infantil'
    fill_in 'Descrição', with: 'Festa para crianças'
    fill_in 'Duração Padrão', with: 240
    fill_in 'Quantidade Mínima de Pessoas', with: 30
    fill_in 'Quantidade Máxima de Pessoas', with: 60
    fill_in 'Duração Padrão', with: 240
    fill_in 'Cardápio', with: 'Bolo, doces, salgados, refrigerante e suco'
    check 'Bebidas Alcoólicas'
    check 'Estacionamento/Valet'

    click_on 'Salvar'

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

  end
end
