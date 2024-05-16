require 'rails_helper'

describe 'business owner changes buffet to' do
  context 'successfully' do
    it 'archived' do
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
      click_on 'Ver meu Buffet'

      expect(page).to have_content 'Desativar Buffet'
      click_on 'Desativar Buffet'

      expect(page).to have_content 'Buffet desativado!'
    end
    it 'unarchived' do
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
        user: kylie,
        archived: true
      )

      login_as(kylie)
      visit root_path
      click_on 'Ver meu Buffet'

      click_on 'Ativar Buffet'

      expect(page).to have_content 'Buffet reativado!'
    end
  end
end
