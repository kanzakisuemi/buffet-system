require 'rails_helper'

describe 'user accesses buffets list' do
  it 'successfully and sees only unarchived buffets - as visitor' do
    kim = User.create!(name: 'Kimberly Noel Kardashian', email: 'kim@kardashian.com', password: 'password123', role: 0)
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
    buffet_kim = Buffet.create!(
      social_name: 'Buffet da Kim',
      corporate_name: 'Buffet da Kim LTDA',
      company_registration_number: CNPJ.generate,
      phone: '995893420',
      email: 'kim@supportkim.com',
      address: 'Rua das Azaléias, 570',
      neighborhood: 'Jardim das Flores',
      city: 'São Paulo',
      state: 'SP',
      zip_code: '12345678',
      description: 'Buffet para eventos icônicos.',
      user: kim,
      archived: true
    )

    visit root_path

    within('nav') do
      click_on 'Buffets'
    end

    expect(page).to have_content('Buffet da Maria')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('SP')
    expect(page).not_to have_content('Buffet da Kim')
  end
  it 'successfully and theres no buffet - as visitor' do
    visit root_path

    within('nav') do
      click_on 'Buffets'
    end

    expect(page).to have_content('Não existem buffets cadastrados')
  end
  it 'successfully and sees only unarchived buffets - as client' do
    kim = User.create!(name: 'Kimberly Noel Kardashian', email: 'kim@kardashian.com', password: 'password123', role: 0)
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
    buffet_kim = Buffet.create!(
      social_name: 'Buffet da Kim',
      corporate_name: 'Buffet da Kim LTDA',
      company_registration_number: CNPJ.generate,
      phone: '995893420',
      email: 'kim@supportkim.com',
      address: 'Rua das Azaléias, 570',
      neighborhood: 'Jardim das Flores',
      city: 'São Paulo',
      state: 'SP',
      zip_code: '12345678',
      description: 'Buffet para eventos icônicos.',
      user: kim,
      archived: true
    )

    login_as(kendall)

    visit root_path

    within('nav') do
      click_on 'Buffets'
    end

    expect(page).to have_content('Buffet da Maria')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('SP')
    expect(page).not_to have_content('Buffet da Kim')
  end
  it 'successfully and theres no buffet - as client' do
    kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
    login_as(kendall)
    visit root_path

    within('nav') do
      click_on 'Buffets'
    end

    expect(page).to have_content('Não existem buffets cadastrados')
  end
  it 'successfully and sees only unarchived buffets - as business owner' do
    kim = User.create!(name: 'Kimberly Noel Kardashian', email: 'kim@kardashian.com', password: 'password123', role: 0)
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
    buffet_kim = Buffet.create!(
      social_name: 'Buffet da Kim',
      corporate_name: 'Buffet da Kim LTDA',
      company_registration_number: CNPJ.generate,
      phone: '995893420',
      email: 'kim@supportkim.com',
      address: 'Rua das Azaléias, 570',
      neighborhood: 'Jardim das Flores',
      city: 'São Paulo',
      state: 'SP',
      zip_code: '12345678',
      description: 'Buffet para eventos icônicos.',
      user: kim,
      archived: true
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
    expect(page).not_to have_content('Buffet da Kim')
  end
end
