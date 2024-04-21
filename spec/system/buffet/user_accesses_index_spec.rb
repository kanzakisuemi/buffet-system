require 'rails_helper'

describe 'user accesses buffets index' do

  let(:kylie) { User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0) }
  let(:kendall) { User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1) }
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

  it 'successfully as client and sees all buffets' do
    buffet
    login_as(kendall)

    visit root_path

    within('nav') do
      click_on 'Buffets'
    end

    expect(page).to have_content('Buffet da Maria')
    expect(page).to have_content('São Paulo')
  end
  it 'successfully as client and theres no buffet' do
    login_as(kendall)
    visit root_path

    within('nav') do
      click_on 'Buffets'
    end

    expect(page).to have_content('Não existem buffets cadastrados')
  end
  it 'successfully as business owner and sees all buffets' do
    buffet
    login_as(kylie)
    visit root_path

    within('nav') do
      click_on 'Buffets'
      click_on 'Todos Buffets'
    end

    expect(page).to have_content('Buffet da Maria')
    expect(page).to have_content('São Paulo')
  end
end
