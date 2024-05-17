require 'rails_helper'

describe 'user tries to register a buffet rating' do
  context 'and fails' do
    it 'as visitor' do
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
        zip_code: '12345689',
        description: 'Buffet para festas infantis e de adultos',
        user: kylie
      )

      post buffet_ratings_path(buffet), params: { rating: { score: 4, review: 'Achei bem bacana.', buffet: buffet, user: nil } }

      expect(response).to redirect_to(new_user_session_path)
    end
    it 'as client w/ no past events from this buffet' do
      felca = User.create!(name: 'Felipe Bressanim', email: 'felca@youtuber.com', password: 'password123', role: 1, social_security_number: CPF.generate)
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
        zip_code: '12345689',
        description: 'Buffet para festas infantis e de adultos',
        user: kylie
      )

      login_as(felca)
      post buffet_ratings_path(buffet), params: { rating: { score: 4, review: 'Achei bem bacana.', buffet: buffet, user: felca } }

      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq 'Você não pode avaliar um buffet sem ter feito um evento com ele.'
    end
    it 'as business owner' do
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
        zip_code: '12345689',
        description: 'Buffet para festas infantis e de adultos',
        user: kylie
      )

      login_as(kylie)
      post buffet_ratings_path(buffet), params: { rating: { score: 4, review: 'Achei bem bacana.', buffet: buffet, user: kylie } }

      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq 'Você não pode avaliar um buffet.'
    end
    it 'as client w/ past events but already rated' do
      felca = User.create!(name: 'Felipe Bressanim', email: 'felca@youtuber.com', password: 'password123', role: 1, social_security_number: CPF.generate)
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
        zip_code: '12345689',
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
      order = Order.create!(
        event_date: 3.days.from_now,
        guests_estimation: 45,
        event_details: 'Festa de aniversário de 5 anos da Maria',
        event_address: nil,
        event_type_id: event_type.id,
        user: felca,
        charge_fee: true,
        grant_discount: false,
        extra_fee: 100.00,
        discount: nil,
        budget_details: 'Taxa extra de 100 reais para cobrir deslocamento.',
        due_date: 2.days.from_now,
        status: 2
      )
      Rating.create!(score: 5, review: 'Adorei, achei muito bacana.', buffet: buffet, user: felca)

      travel_to 4.days.from_now do
        login_as(felca)
        post buffet_ratings_path(buffet), params: { rating: { score: 4, review: 'Achei bem bacana.', buffet: buffet, user: felca } }

        expect(response).to redirect_to(root_path)
      end
    end
  end
end
