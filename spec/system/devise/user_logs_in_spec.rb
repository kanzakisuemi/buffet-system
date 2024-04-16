require 'rails_helper'

describe 'User logs in' do
  it 'through navbar link' do
    User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)

    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'khy@jenner.com'
      fill_in 'Senha', with: 'password123'
      click_on 'Entrar'
    end

    expect(page).to have_content('khy@jenner.com')
    expect(page).to have_content('Login efetuado com sucesso.')
    expect(page).to have_content('Dono de Buffet')
  end
  it 'and logs out' do
    User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)

    visit root_path
    click_on 'Entrar'
    within('form') do
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
end
