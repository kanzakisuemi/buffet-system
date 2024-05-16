require 'rails_helper'

describe 'user tries to submit an order' do
  context 'as client' do
    it 'and buffet has no event types registered' do
      kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
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

      login_as(kendall)
      visit root_path

      click_on 'Buffets'
      click_on 'Buffet da Maria'
      click_on 'Contratar Buffet'

      expect(current_path).to eq(buffet_path(buffet))
      expect(page).to have_content('Este Buffet ainda não possui nenhum evento cadastrado')
    end
    it 'and succeds' do
      kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
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
      event_type = EventType.create!(
        category: 3,
        name: 'Festa Infantil',
        description: 'Festa para crianças',
        default_duration_minutes: 240,
        minimal_people_capacity: 30,
        maximal_people_capacity: 60,
        food_menu: 'Bolo, doces, salgados, refrigerante e suco',
        alcoholic_drinks: true,
        parking_service: true,
        buffet: kylie.buffet,
        base_price: 1000.00,
        weekend_fee: 20,
        per_person_fee: 50.00,
        per_person_weekend_fee: 20,
        per_hour_fee: 100.00,
        per_hour_weekend_fee: 50
      )

      login_as(kendall)
      visit root_path

      click_on 'Buffets'
      click_on 'Buffet da Maria'
      click_on 'Contratar Buffet'

      click_on 'Festa Infantil'
      fill_in 'Data do Evento', with: 10.days.from_now
      fill_in 'Quantidade de Convidados', with: 50
      expect(page).not_to have_content('event_address')
      click_on 'Agendar Evento'

      expect(current_path).to eq(order_path(Order.last))
      expect(page).to have_content('Festa Infantil')
      expect(page).to have_content(10.days.from_now.strftime('%d/%m/%Y'))
      expect(page).to have_content('50')
    end
    it 'w/out filling all mandatory fields and fails' do
      kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
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
      event_type = EventType.create!(
        category: 3,
        name: 'Festa Infantil',
        description: 'Festa para crianças',
        default_duration_minutes: 240,
        minimal_people_capacity: 30,
        maximal_people_capacity: 60,
        food_menu: 'Bolo, doces, salgados, refrigerante e suco',
        alcoholic_drinks: true,
        parking_service: true,
        buffet: kylie.buffet,
        base_price: 1000.00,
        weekend_fee: 20,
        per_person_fee: 50.00,
        per_person_weekend_fee: 20,
        per_hour_fee: 100.00,
        per_hour_weekend_fee: 50
      )

      login_as(kendall)
      visit root_path

      click_on 'Buffets'
      click_on 'Buffet da Maria'
      click_on 'Contratar Buffet'

      click_on 'Festa Infantil'
      fill_in 'Data do Evento', with: nil
      fill_in 'Quantidade de Convidados', with: 50
      expect(page).not_to have_content('event_address')
      click_on 'Agendar Evento'

      expect(page).to have_content('Data do Evento não pode ficar em branco')
    end
  end
  context 'as visitor' do
    it 'and must be authenticated' do
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
      event_type = EventType.create!(
        category: 3,
        name: 'Festa Infantil',
        description: 'Festa para crianças',
        default_duration_minutes: 240,
        minimal_people_capacity: 30,
        maximal_people_capacity: 60,
        food_menu: 'Bolo, doces, salgados, refrigerante e suco',
        alcoholic_drinks: true,
        parking_service: true,
        buffet: kylie.buffet,
        base_price: 1000.00,
        weekend_fee: 20,
        per_person_fee: 50.00,
        per_person_weekend_fee: 20,
        per_hour_fee: 100.00,
        per_hour_weekend_fee: 50
      )

      visit root_path

      click_on 'Buffets'
      click_on 'Buffet da Maria'
      click_on 'Contratar Buffet'
      click_on 'Festa Infantil'

      expect(current_path).to eq(new_user_session_path)
    end
  end
  context 'as business owner' do
    it 'and does not find the hire button' do
      kim = User.create!(name: 'Kimberly Noel Kardashian', email: 'kim@kardashian.com', password: 'password123', role: 0)
      kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
      buffet_ky = Buffet.create!(
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
        user: kim
      )
      event_type = EventType.create!(
        category: 3,
        name: 'Festa Infantil',
        description: 'Festa para crianças',
        default_duration_minutes: 240,
        minimal_people_capacity: 30,
        maximal_people_capacity: 60,
        food_menu: 'Bolo, doces, salgados, refrigerante e suco',
        alcoholic_drinks: true,
        parking_service: true,
        buffet: kylie.buffet,
        base_price: 1000.00,
        weekend_fee: 20,
        per_person_fee: 50.00,
        per_person_weekend_fee: 20,
        per_hour_fee: 100.00,
        per_hour_weekend_fee: 50
      )

      login_as(kim)
      visit root_path

      click_on 'Buffets'
      click_on 'Todos Buffets'
      click_on 'Buffet da Maria'

      expect(page).not_to have_content 'Contratar Buffet'
    end
  end
end
