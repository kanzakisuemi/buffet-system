require 'rails_helper'

describe 'User logs in' do
  it 'as business owner and does not have a buffet' do
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)

    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'E-mail', with: 'khy@jenner.com'
      fill_in 'Senha', with: 'password123'
      click_on 'Entrar'
    end

    expect(current_path).to eq(new_buffet_path)
    expect(page).to have_content('Registro de Buffet')
  end
  it 'as business owner and having a buffet' do
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)

    Buffet.create!(
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
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'E-mail', with: 'khy@jenner.com'
      fill_in 'Senha', with: 'password123'
      click_on 'Entrar'
    end

    expect(current_path).to eq(root_path)
    within('nav') do
      expect(page).to have_content('khy@jenner.com')
    end
  end
  it 'as business owner and logs out' do
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)

    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'E-mail', with: 'khy@jenner.com'
      fill_in 'Senha', with: 'password123'
      click_on 'Entrar'
    end

    within('nav') do
      click_on 'Sair'
    end

    expect(page).to have_content('Entrar')
    expect(page).to have_content('Logout efetuado com sucesso.')
  end
  it 'as business owner and fails' do
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)

    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'E-mail', with: 'khy@jenner.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    
    expect(page).to have_content('E-mail ou senha inválidos.')
  end
end
