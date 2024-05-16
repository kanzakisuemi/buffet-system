require 'rails_helper'

describe 'business owner edits buffet' do
  context 'successfully' do
    it 'adding payment methods' do
      kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
      cnpj = CNPJ.generate
      buffet = Buffet.create!(
        social_name: 'Buffet da Maria',
        corporate_name: 'Buffet da Maria LTDA',
        company_registration_number: cnpj,
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
      PaymentMethod.create!(name: 'Cartão de Crédito')
      PaymentMethod.create!(name: 'Cartão de Débito')
      
      login_as(kylie)
      visit root_path

      within('nav') do
        click_on 'Buffets'
        click_on 'Ver meu Buffet'
      end

      expect(current_path).to eq(buffet_path(kylie.buffet))
      click_on 'Editar Buffet'

      expect(page).to have_field('Nome Social', with: 'Buffet da Maria')
      expect(page).to have_field('Razão Social', with: 'Buffet da Maria LTDA')
      expect(page).to have_field('CNPJ', with: cnpj)
      expect(page).to have_field('Telefone', with: '996348000')
      expect(page).to have_field('E-mail', with: 'maria@email.com')
      expect(page).to have_field('Endereço', with: 'Rua das Flores, 230')
      expect(page).to have_field('Bairro', with: 'Jardim das Flores')
      expect(page).to have_field('Cidade', with: 'São Paulo')
      expect(page).to have_field('Estado', with: 'SP')
      expect(page).to have_field('CEP', with: '12345678')
      expect(page).to have_field('Descrição', with: 'Buffet para festas infantis e de adultos')
      check 'Cartão de Crédito'
      check 'Cartão de Débito'
      click_on 'Registrar'

      expect(current_path).to eq(buffet_path(Buffet.last))
      expect(page).to have_content('Editar Buffet')
      expect(page).to have_content('Buffet da Maria')
      expect(page).to have_content('Buffet da Maria LTDA')
      expect(page).to have_content(cnpj)
      expect(page).to have_content('996348000')
      expect(page).to have_content('maria@email.com')
      expect(page).to have_content('Rua das Flores, 230')
      expect(page).to have_content('Jardim das Flores')
      expect(page).to have_content('São Paulo')
      expect(page).to have_content('SP')
      expect(page).to have_content('12345678')
      expect(page).to have_content('Buffet para festas infantis e de adultos')
      expect(page).to have_content('Kylie Kristen Jenner')
      expect(page).to have_content('Cartão de Crédito')
      expect(page).to have_content('Cartão de Débito')
    end
  end
  context 'and fails' do
    it 'removing mandatory fiels' do
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
        click_on 'Ver meu Buffet'
      end

      click_on 'Editar Buffet'
      fill_in 'CNPJ', with: nil
      click_on 'Registrar'

      expect(page).to have_content('CNPJ não pode ficar em branco')
    end
  end
end
