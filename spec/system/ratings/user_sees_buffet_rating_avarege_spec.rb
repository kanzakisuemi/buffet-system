require 'rails_helper'

describe 'user sees buffet rating' do
  context 'successfully' do
    it 'as client' do
      kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
      matheus = User.create!(name: 'Matheus Bellucio', email: 'belluciom@mail.com', password: 'password123', role: 1, social_security_number: CPF.generate)
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
        payment_methods: [ ]
      )
      Rating.create!(score: 5, review: 'Achei hiper bacana.', buffet: buffet, user: kendall)
      Rating.create!(score: 3, review: 'Achei que não foi bacana.', buffet: buffet, user: matheus)
      
      travel_to 6.days.from_now do
        login_as(kendall)
        visit root_path

        click_on 'Buffets'
        click_on buffet.social_name

        within('div#ratings') do
          expect(page).to have_content('4')
        end
      end
    end
    it 'as business owner' do
      kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
      matheus = User.create!(name: 'Matheus Bellucio', email: 'belluciom@mail.com', password: 'password123', role: 1, social_security_number: CPF.generate)
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
        payment_methods: [ ]
      )
      Rating.create!(score: 5, review: 'Achei hiper bacana.', buffet: buffet, user: kendall)
      Rating.create!(score: 3, review: 'Achei que não foi bacana.', buffet: buffet, user: matheus)
      
      travel_to 6.days.from_now do
        login_as(kylie)
        visit root_path

        click_on 'Ver meu Buffet'

        within('div#ratings') do
          expect(page).to have_content('4')
        end
      end
    end
    it 'as visitor' do
      kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
      matheus = User.create!(name: 'Matheus Bellucio', email: 'belluciom@mail.com', password: 'password123', role: 1, social_security_number: CPF.generate)
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
        payment_methods: [ ]
      )
      Rating.create!(score: 5, review: 'Achei hiper bacana.', buffet: buffet, user: kendall)
      Rating.create!(score: 3, review: 'Achei que não foi bacana.', buffet: buffet, user: matheus)
      
      travel_to 6.days.from_now do
        visit root_path

        click_on 'Buffets'
        click_on buffet.social_name

        within('div#ratings') do
          expect(page).to have_content('4')
        end
      end
    end
  end
end
