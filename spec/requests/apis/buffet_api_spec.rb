require 'rails_helper'

describe 'buffet api' do
  context 'GET /api/v1/buffet/1' do
    it 'success' do
      felipe = User.create!(name: 'Felipe Chineze', email: 'felipe@email.com', password: 'password123', role: 0)
      kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
      matheus = User.create!(name: 'Matheus Bellucio', email: 'belluciom@mail.com', password: 'password123', role: 1, social_security_number: CPF.generate)
      debit = PaymentMethod.create(name: 'Cartão de Crédito')
      credit = PaymentMethod.create(name: 'Cartão de Débito')
      buffet = Buffet.create!(
        social_name: 'Planalto', 
        corporate_name: 'Buffet Planalto LTDA',
        company_registration_number: CNPJ.generate,
        phone: '4333385038',
        email: 'contato@planalto.com',
        address: 'Av. Tiradentes, 6429',
        neighborhood: 'Parque Ney Braga',
        city: 'Londrina',
        state: 'PR',
        zip_code: '86072000',
        description: 'Buffet para festas grandes e chiques.',
        user: felipe,
        payment_methods: [ debit, credit ]
      )
      Rating.create!(score: 5, review: 'Achei hiper bacana.', buffet: buffet, user: kendall)
      Rating.create!(score: 3, review: 'Achei que não foi bacana.', buffet: buffet, user: matheus)
      
      get "/api/v1/buffets/#{buffet.id}"

      json_response = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      
      expect(json_response["social_name"]).to eq buffet.social_name
      expect(json_response.keys).to include 'rating_average'
      expect(json_response.keys).not_to include 'corporate_name'
      expect(json_response.keys).not_to include 'company_registration_number'
    end
    it 'fail if buffet is not found' do
    
      get "/api/v1/buffets/1"

      expect(response.status).to eq 404
    end
  end
  context 'GET /api/v1/buffets' do
    it 'successfully - only unarchived buffets' do
      felipe = User.create!(name: 'Felipe Chineze', email: 'felipe@email.com', password: 'password123', role: 0)
      rafa = User.create!(name: 'Rafaela Bruschi', email: 'rafa@outlook.com', password: 'password123', role: 0)
      antonia = User.create!(name: 'Antonia Grassano', email: 'antonia@angra.com', password: 'password123', role: 0)
      planalto = Buffet.create!(
        social_name: 'Planalto', 
        corporate_name: 'Buffet Planalto LTDA',
        company_registration_number: CNPJ.generate,
        phone: '4333385038',
        email: 'contato@planalto.com',
        address: 'Av. Tiradentes, 6429',
        neighborhood: 'Parque Ney Braga',
        city: 'Londrina',
        state: 'PR',
        zip_code: '86072000',
        description: 'Buffet para festas grandes e chiques.',
        user: felipe
      )
      baby_buffet = Buffet.create!(
        social_name: 'Baby Buffet', 
        corporate_name: 'Bruschi SA',
        company_registration_number: CNPJ.generate,
        phone: '4333367098',
        email: 'suporte@babybuffet.com',
        address: 'Rua Santiago, 581',
        neighborhood: 'Bela Suíça',
        city: 'Londrina',
        state: 'PR',
        zip_code: '86050180',
        description: 'Buffet ideal para celebrar festas de bebês!',
        user: rafa
      )
      angra = Buffet.create!(
        social_name: 'Angra', 
        corporate_name: 'Angra MEI',
        company_registration_number: CNPJ.generate,
        events_per_day: 2,
        phone: '4333301264',
        email: 'antonia@mail.com',
        address: 'Rua do Aurora, 508',
        neighborhood: 'Gleba Palhano',
        city: 'Londrina',
        state: 'PR',
        zip_code: '86050600',
        description: 'Buffet focado em alimentos saudáveis e fitness, refeições e doces milimetricamente avaliados pela nutri Antonia Grassano.',
        user: antonia,
        archived: true
      )
      
      get '/api/v1/buffets'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response.length).to eq 2
      expect(json_response[0]['social_name']).to eq baby_buffet.social_name
      expect(json_response[1]['social_name']).to eq planalto.social_name
    end
    it 'empty if there is no buffet' do
      get '/api/v1/buffets'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end
    it 'and raise internal error' do
      allow(Buffet).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

      get '/api/v1/buffets'

      expect(response.status).to eq 500
    end
    it 'success w/ search parameter' do
      felipe = User.create!(name: 'Felipe Chineze', email: 'felipe@email.com', password: 'password123', role: 0)
      rafa = User.create!(name: 'Rafaela Bruschi', email: 'rafa@outlook.com', password: 'password123', role: 0)
      planalto = Buffet.create!(
        social_name: 'Planalto', 
        corporate_name: 'Buffet Planalto LTDA',
        company_registration_number: CNPJ.generate,
        phone: '4333385038',
        email: 'contato@planalto.com',
        address: 'Av. Tiradentes, 6429',
        neighborhood: 'Parque Ney Braga',
        city: 'Londrina',
        state: 'PR',
        zip_code: '86072000',
        description: 'Buffet para festas grandes e chiques.',
        user: felipe
      )
      baby_buffet = Buffet.create!(
        social_name: 'Baby Buffet', 
        corporate_name: 'Bruschi SA',
        company_registration_number: CNPJ.generate,
        phone: '4333367098',
        email: 'suporte@babybuffet.com',
        address: 'Rua Santiago, 581',
        neighborhood: 'Bela Suíça',
        city: 'Londrina',
        state: 'PR',
        zip_code: '86050180',
        description: 'Buffet ideal para celebrar festas de bebês!',
        user: rafa
      )
      
      get '/api/v1/buffets', params: { search: 'planalto' }

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response.length).to eq 1
      expect(json_response[0]['social_name']).to eq planalto.social_name
    end
  end
  context 'GET /api/v1/buffet/1/event_types' do
    it 'successfully - only unarchived event types' do
      felipe = User.create!(name: 'Felipe Chineze', email: 'felipe@email.com', password: 'password123', role: 0)
      buffet = Buffet.create!(
        social_name: 'Planalto', 
        corporate_name: 'Buffet Planalto LTDA',
        company_registration_number: CNPJ.generate,
        phone: '4333385038',
        email: 'contato@planalto.com',
        address: 'Av. Tiradentes, 6429',
        neighborhood: 'Parque Ney Braga',
        city: 'Londrina',
        state: 'PR',
        zip_code: '86072000',
        description: 'Buffet para festas grandes e chiques.',
        user: felipe,
        payment_methods: [ ]
      )
      casamento = EventType.create!(
        category: 2,
        name: 'Casamento de Luxo',
        description: 'Casamento para casais de alto padrão.',
        default_duration_minutes: 300,
        minimal_people_capacity: 200,
        maximal_people_capacity: 400,
        food_menu: 'Entrada: Camarão Empanado. Prato principal: Risoto de Cogumelos. Sobremesa: Tiramisu.',
        alcoholic_drinks: true,
        decoration: true,
        location_flexibility: false,
        parking_service: true,
        buffet: felipe.buffet,
        base_price: 15000.00,
        weekend_fee: 20,
        per_person_fee: 70.00,
        per_person_weekend_fee: 20,
        per_hour_fee: 400.00,
        per_hour_weekend_fee: 50
      )
      bodas = EventType.create!(
        category: 3,
        name: 'Aniversários de Casamento',
        description: 'Festa de Bodas e Renovação de Votos.',
        default_duration_minutes: 180,
        minimal_people_capacity: 150,
        maximal_people_capacity: 230,
        food_menu: 'Entrada: Camarão Empanado. Prato principal: Refeição Surpresa. Sobremesa: Gelatto.',
        alcoholic_drinks: true,
        decoration: true,
        location_flexibility: false,
        parking_service: true,
        buffet: felipe.buffet,
        base_price: 9000.00,
        weekend_fee: 10,
        per_person_fee: 70.00,
        per_person_weekend_fee: 20,
        per_hour_fee: 400.00,
        per_hour_weekend_fee: 50
      )
      niver = EventType.create!(
        category: 3,
        name: 'Aniversário de Idoso',
        description: 'Festa de Aniversário para idosos.',
        default_duration_minutes: 180,
        minimal_people_capacity: 100,
        maximal_people_capacity: 200,
        food_menu: 'Entrada: Camarão Empanado. Prato principal: Refeição Surpresa. Sobremesa: Torta de Framboesa.',
        alcoholic_drinks: true,
        decoration: true,
        location_flexibility: false,
        parking_service: true,
        buffet: felipe.buffet,
        base_price: 9000.00,
        weekend_fee: 10,
        per_person_fee: 70.00,
        per_person_weekend_fee: 20,
        per_hour_fee: 400.00,
        per_hour_weekend_fee: 50,
        archived: true
      )
      
      get "/api/v1/buffets/#{buffet.id}/event_types"

      json_response = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      
      expect(json_response.length).to eq 2
      expect(json_response[0]['name']).to eq bodas.name
      expect(json_response[1]['name']).to eq casamento.name
    end
    it 'fail if buffet is not found' do
    
      get "/api/v1/buffets/1/event_types"

      expect(response.status).to eq 404
    end
  end
end
