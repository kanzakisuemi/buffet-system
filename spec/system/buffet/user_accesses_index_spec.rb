require 'rails_helper'

describe 'user accesses buffets index' do
  it 'successfully as visitor and sees all buffets' do
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

    visit root_path

    within('nav') do
      click_on 'Buffets'
    end

    expect(page).to have_content('Buffet da Maria')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('SP')
  end
  it 'successfully as visitor and theres no buffet' do
    visit root_path

    within('nav') do
      click_on 'Buffets'
    end

    expect(page).to have_content('Não existem buffets cadastrados')
  end
  it 'successfully as client and sees all buffets' do
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
    kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
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
    login_as(kendall)

    visit root_path

    within('nav') do
      click_on 'Buffets'
    end

    expect(page).to have_content('Buffet da Maria')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('SP')
  end
  it 'successfully as client and theres no buffet' do
    kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
    login_as(kendall)
    visit root_path

    within('nav') do
      click_on 'Buffets'
    end

    expect(page).to have_content('Não existem buffets cadastrados')
  end
  it 'successfully as business owner and sees all buffets' do
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
    login_as(kylie)
    visit root_path

    within('nav') do
      click_on 'Buffets'
      click_on 'Todos Buffets'
    end

    expect(page).to have_content('Buffet da Maria')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('SP')
  end
end
