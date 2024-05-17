require 'rails_helper'

describe 'user sees all ratings of a specific buffet' do
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
      Rating.create!(score: 2, review: 'Achei bem esquisito o evento.', buffet: buffet, user: orochinho)
      
      visit root_path

      click_on 'Buffets'
      click_on buffet.social_name

      within('div#ratings') do
        click_on 'Ver todas as avaliações'
      end

      expect(page).to have_content('Kendall Jenner')
      expect(page).to have_content('Achei hiper bacana.')
      expect(page).to have_content('Matheus Bellucio')
      expect(page).to have_content('Achei que não foi bacana.')
      expect(page).to have_content('Pedro Orochi')
      expect(page).to have_content('Achei bem esquisito o evento.')
      expect(page).to have_content('Felipe Bressanim')
      expect(page).to have_content('Achei bem bacana.')
    end
    it 'as client' do
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
      Rating.create!(score: 2, review: 'Achei bem esquisito o evento.', buffet: buffet, user: orochinho)

      login_as(kendall)
      visit root_path

      click_on 'Buffets'
      click_on buffet.social_name

      within('div#ratings') do
        click_on 'Ver todas as avaliações'
      end

      expect(page).to have_content('Kendall Jenner')
      expect(page).to have_content('Achei hiper bacana.')
      expect(page).to have_content('Matheus Bellucio')
      expect(page).to have_content('Achei que não foi bacana.')
      expect(page).to have_content('Pedro Orochi')
      expect(page).to have_content('Achei bem esquisito o evento.')
      expect(page).to have_content('Felipe Bressanim')
      expect(page).to have_content('Achei bem bacana.')
    end
    it 'as business owner' do
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
      Rating.create!(score: 2, review: 'Achei bem esquisito o evento.', buffet: buffet, user: orochinho)
      
      login_as(kylie)
      visit root_path

      click_on 'Ver meu Buffet'

      within('div#ratings') do
        click_on 'Ver todas as avaliações'
      end

      expect(page).to have_content('Kendall Jenner')
      expect(page).to have_content('Achei hiper bacana.')
      expect(page).to have_content('Matheus Bellucio')
      expect(page).to have_content('Achei que não foi bacana.')
      expect(page).to have_content('Pedro Orochi')
      expect(page).to have_content('Achei bem esquisito o evento.')
      expect(page).to have_content('Felipe Bressanim')
      expect(page).to have_content('Achei bem bacana.')
    end
  end
  it 'and there are no ratings' do
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

    visit root_path

    click_on 'Buffets'
    click_on buffet.social_name

    within('div#ratings') do
      expect(page).to have_content 'Este buffet ainda não possui nenhuma validação.'
    end
  end
end
