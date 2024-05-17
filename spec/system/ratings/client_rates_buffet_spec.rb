require 'rails_helper'

describe 'client rates buffet' do
  context 'successfully' do
    it 'after event date' do
      kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
      kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
      pix = PaymentMethod.create!(name: 'Pix')
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
        payment_methods: [ pix ]
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
      order = Order.create!(
        event_date: 3.days.from_now,
        guests_estimation: 45,
        event_details: 'Festa de aniversário de 5 anos da Maria',
        event_address: nil,
        event_type_id: event_type.id,
        user: kendall,
        payment_method_id: pix.id,
        charge_fee: true,
        grant_discount: false,
        extra_fee: 100.00,
        discount: nil,
        budget_details: 'Taxa extra de 100 reais para cobrir deslocamento.',
        due_date: 2.days.from_now,
        status: 2
      )
      
      travel_to 4.days.from_now do
        login_as(kendall)
        visit root_path

        click_on 'Buffets'
        click_on buffet.social_name

        click_on 'Avaliar Buffet'
        
        find("#rating_score_5").click
        fill_in 'Avaliação', with: 'Adorei, achei muito bacana.'
        attach_file 'Fotos do Evento', Rails.root.join('spec', 'files', 'reuri.jpeg')
        click_on 'Enviar Avaliação'

        expect(page).to have_content('Avaliação enviada com sucesso!')
      end
    end
  end
  context 'and fails' do
    it 'after event date w/out mandatory fields' do
      kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
      kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
      pix = PaymentMethod.create!(name: 'Pix')
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
        payment_methods: [ pix ]
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
      order = Order.create!(
        event_date: 3.days.from_now,
        guests_estimation: 45,
        event_details: 'Festa de aniversário de 5 anos da Maria',
        event_address: nil,
        event_type_id: event_type.id,
        user: kendall,
        payment_method_id: pix.id,
        charge_fee: true,
        grant_discount: false,
        extra_fee: 100.00,
        discount: nil,
        budget_details: 'Taxa extra de 100 reais para cobrir deslocamento.',
        due_date: 2.days.from_now,
        status: 2
      )
      
      travel_to 4.days.from_now do
        login_as(kendall)
        visit root_path

        click_on 'Buffets'
        click_on buffet.social_name

        click_on 'Avaliar Buffet'
        
        fill_in 'Avaliação', with: nil
        attach_file 'Fotos do Evento', Rails.root.join('spec', 'files', 'reuri.jpeg')
        click_on 'Enviar Avaliação'

        expect(page).to have_content('Não foi possível enviar sua avaliação.')
      end
    end
    it 'before event date' do
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
        user: kylie,
        payment_methods: [ ]
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
      order = Order.create!(
        event_date: 3.days.from_now,
        guests_estimation: 45,
        event_details: 'Festa de aniversário de 5 anos da Maria',
        event_address: nil,
        event_type_id: event_type.id,
        user: kendall,
        charge_fee: true,
        grant_discount: false,
        extra_fee: 100.00,
        discount: nil,
        budget_details: 'Taxa extra de 100 reais para cobrir deslocamento.',
        due_date: 2.days.from_now,
        status: 2
      )
      
      login_as(kendall)
      visit root_path

      click_on 'Buffets'
      click_on buffet.social_name

      expect(page).not_to have_content 'Avaliar Buffet'
    end
    it 'when rating is already done' do
      kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
      kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
      pix = PaymentMethod.create!(name: 'Pix')
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
        payment_methods: [ pix ]
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
      order = Order.create!(
        event_date: 3.days.from_now,
        guests_estimation: 45,
        event_details: 'Festa de aniversário de 5 anos da Maria',
        event_address: nil,
        event_type_id: event_type.id,
        user: kendall,
        payment_method_id: pix.id,
        charge_fee: true,
        grant_discount: false,
        extra_fee: 100.00,
        discount: nil,
        budget_details: 'Taxa extra de 100 reais para cobrir deslocamento.',
        due_date: 2.days.from_now,
        status: 2
      )
      Rating.create!(score: 5, review: 'Achei hiper bacana.', buffet: buffet, user: kendall)

      travel_to 4.days.from_now do
        login_as(kendall)
        visit root_path

        click_on 'Buffets'
        click_on buffet.social_name

        expect(page).not_to have_content 'Avaliar Buffet'
      end
    end
  end
end
