require 'rails_helper'

describe 'business owner registers buffet' do
  it 'successfully right after signing up' do
    cnpj = CNPJ.generate
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

    expect(page).to have_content('Registro de Buffet')
    
    fill_in 'Nome Social', with: 'Buffet da Maria'
    fill_in 'Razão Social', with: 'Buffet da Maria LTDA'
    fill_in 'CNPJ', with: cnpj
    fill_in 'Telefone', with: '996348000'
    fill_in 'E-mail', with: 'maria@email.com'
    fill_in 'Endereço', with: 'Rua das Flores, 230'
    fill_in 'Bairro', with: 'Jardim das Flores'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'CEP', with: '123456'
    fill_in 'Descrição', with: 'Buffet para festas infantis e de adultos'
    click_on 'Registrar'
    
    expect(current_path).to eq(buffet_path(Buffet.last))
    expect(page).to have_content('Buffet da Maria')
    expect(page).to have_content('Buffet da Maria LTDA')
    expect(page).to have_content(cnpj)
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
  it 'successfully with payment methods' do
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
    PaymentMethod.create!(name: 'Dinheiro')
    PaymentMethod.create!(name: 'Cartão de Crédito')
    PaymentMethod.create!(name: 'Cartão de Débito')
    cnpj = CNPJ.generate

    login_as(kylie)
    visit root_path

    expect(page).to have_content('Registro de Buffet')
    
    fill_in 'Nome Social', with: 'Buffet da Maria'
    fill_in 'Razão Social', with: 'Buffet da Maria LTDA'
    fill_in 'CNPJ', with: cnpj
    fill_in 'Telefone', with: '996348000'
    fill_in 'E-mail', with: 'maria@email.com'
    fill_in 'Endereço', with: 'Rua das Flores, 230'
    fill_in 'Bairro', with: 'Jardim das Flores'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'CEP', with: '123456'
    fill_in 'Descrição', with: 'Buffet para festas infantis e de adultos'
    check 'Dinheiro'
    check 'Cartão de Crédito'
    check 'Cartão de Débito'

    click_on 'Registrar'
    
    expect(current_path).to eq(buffet_path(Buffet.last))
    expect(page).to have_content('Buffet da Maria')
    expect(page).to have_content('Buffet da Maria LTDA')
    expect(page).to have_content(cnpj)
    expect(page).to have_content('996348000')
    expect(page).to have_content('maria@email.com')
    expect(page).to have_content('Rua das Flores, 230')
    expect(page).to have_content('Jardim das Flores')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('SP')
    expect(page).to have_content('123456')
    expect(page).to have_content('Buffet para festas infantis e de adultos')
    expect(page).to have_content('Kylie Kristen Jenner')
    expect(page).to have_content('Dinheiro')
    expect(page).to have_content('Cartão de Crédito')
    expect(page).to have_content('Cartão de Débito')
    expect(page).not_to have_content('Pix')
    expect(page).not_to have_content('Transferência Bancária')
  end
end
