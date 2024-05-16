require 'rails_helper'

describe 'User signs up' do
  it 'as business owner through navbar' do
    visit root_path

    click_on 'Entrar'
    click_on 'Criar Conta'

    within('form#new_user') do
      fill_in 'Nome', with: 'Kylie Kristen Jenner'
      select 'Dono de Buffet', from: 'Perfil'
      fill_in 'E-mail', with: 'khy@jenner.com'
      fill_in 'Senha', with: 'password123'
      fill_in 'Confirme sua senha', with: 'password123'
      click_on 'Registrar'
    end

    expect(page).to have_content('khy@jenner.com')
  end
  it 'as client through navbar' do
    visit root_path

    click_on 'Entrar'
    click_on 'Criar Conta'

    within('form#new_user') do
      fill_in 'Nome', with: 'Kylie Kristen Jenner'
      select 'Cliente', from: 'Perfil'
      fill_in 'CPF', with: CPF.generate
      fill_in 'E-mail', with: 'khy@jenner.com'
      fill_in 'Senha', with: 'password123'
      fill_in 'Confirme sua senha', with: 'password123'
      click_on 'Registrar'
    end

    expect(page).to have_content('khy@jenner.com')
  end
end
