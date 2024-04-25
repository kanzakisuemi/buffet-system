require 'rails_helper'

describe 'user sees buffet details' do

  let(:kylie) { User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0) }
  let(:kendall) { User.create!(name: 'Kendall Jenner', email: 'kendall@jenner.com', password: 'password123', role: 1) }
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

  it 'as business owner successfully through navbar' do
    buffet
    login_as(kylie)
    visit root_path

    within('nav') do
      click_on 'Buffets'
      click_on 'Ver meu Buffet'
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
  it 'as client through navbar and fails' do
    buffet
    login_as(kendall)
    visit root_path

    within('nav') do
      click_on 'Buffets'
      expect(page).not_to have_link('Ver meu Buffet')
    end
  end
  it 'as client successfully' do
    buffet
    login_as(kendall)
    visit root_path

    within('nav') do
      click_on 'Buffets'
    end

    click_on 'Buffet da Maria | São Paulo | SP'
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
  it 'as visitor successfully and does not see corporate name' do
    buffet
    visit root_path

    within('nav') do
      click_on 'Buffets'
    end

    click_on 'Buffet da Maria | São Paulo | SP'
    expect(page).to have_content('Buffet da Maria')
    expect(page).not_to have_content('Buffet da Maria LTDA')
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
end
