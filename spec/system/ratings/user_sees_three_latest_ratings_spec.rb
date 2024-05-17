require 'rails_helper'

describe 'user sees 3 latest reviews' do
  context 'successfully' do
    it 'as visitor' do
      felca = User.create!(name: 'Felipe Bressanim', email: 'felca@youtuber.com', password: 'password123', role: 1, social_security_number: CPF.generate)
      orochinho = User.create!(name: 'Pedro Orochi', email: 'pedro@mail.com', password: 'password123', role: 1, social_security_number: CPF.generate)
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
      Rating.create!(score: 4, review: 'Achei bem bacana.', buffet: buffet, user: felca)
      rating = Rating.new(score: 4, review: 'Bem legal hehe.', buffet: buffet, user: orochinho)
      rating.pictures.attach(io: File.open('app/assets/images/londrina_planalto.jpg'), filename: 'londrina_planalto.jpg')
      rating.save
      
      visit root_path

      click_on 'Buffets'
      click_on buffet.social_name

      within('div#ratings') do
        expect(page).to have_content('Matheus Bellucio')
        expect(page).to have_content('Achei que não foi bacana.')
        expect(page).to have_content('Pedro Orochi')
        expect(page).to have_content('Bem legal hehe.')
        find('.img-thumbnail')
        expect(page).to have_content('Felipe Bressanim')
        expect(page).to have_content('Achei bem bacana.')
      end
    end
    it 'as client' do
    end
    it 'as business owner' do
    end
  end
end
