require 'rails_helper'

describe 'user sees buffet details' do
  it 'as business owner successfully through navbar' do
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
      click_on 'Buffet'
      click_on 'Ver Buffet'
    end

    expect(current_path).to eq(buffet_path(kylie.buffet))
    expect(page).to have_content('Buffet da Maria')
    expect(page).to have_content('Buffet da Maria LTDA')
    expect(page).to have_content('12345678910111')
    expect(page).to have_content('996348000')
    expect(page).to have_content('maria@email.com')
    expect(page).to have_content('Rua das Flores, 230')
    expect(page).to have_content('Jardim das Flores')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('SP')
    expect(page).to have_content('123456')
    expect(page).to have_content('Buffet para festas infantis e de adultos')
    expect(page).to have_content('Kylie Kristen Jenner')
  end
  it 'as business owner through navbar and fails' do
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)

    login_as(kylie)
    visit root_path

    within('nav') do
      expect(page).not_to have_link('Buffets')
      expect(page).to have_link('Registrar Buffet')
    end
  end
  it 'as client through navbar and fails' do
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
    kenny = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1)

    login_as(kenny)
    visit root_path

    within('nav') do
      click_on 'Buffets'
      expect(page).not_to have_link('Ver Buffet')
    end
  end
end
