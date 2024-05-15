require 'rails_helper'
# available_api_v1_event_type
# GET /api/v1/event_types/:id/available(.:format)
describe 'event types api' do
  context 'GET /api/v1/event_types/:id/available' do
    it 'and event is bookable' do
      felipe = User.create!(name: 'Felipe Chineze', email: 'felipe@email.com', password: 'password123', role: 0)
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
        buffet: planalto,
        base_price: 15000.00,
        weekend_fee: 20,
        per_person_fee: 70.00,
        per_person_weekend_fee: 20,
        per_hour_fee: 400.00,
        per_hour_weekend_fee: 50
      )

      get "/api/v1/event_types/1/available", params: { order: { event_type_id: casamento.id, event_date: 5.days.from_now, guests_estimation: 210 } }

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['event_date']).to eq 5.days.from_now.strftime('%Y-%m-%d')
      expect(json_response['guests_estimation']).to eq 210
      expect(json_response['event_price']).to eq "15700.0"
      puts json_response
      puts request.fullpath
    end
    it 'and event is not bookable due to guest quantity' do
      felipe = User.create!(name: 'Felipe Chineze', email: 'felipe@email.com', password: 'password123', role: 0)
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
        buffet: planalto,
        base_price: 15000.00,
        weekend_fee: 20,
        per_person_fee: 70.00,
        per_person_weekend_fee: 20,
        per_hour_fee: 400.00,
        per_hour_weekend_fee: 50
      )

      get "/api/v1/event_types/1/available", params: { order: { event_type_id: casamento.id, event_date: 5.days.from_now, guests_estimation: 401 } }
      expect(response.status).to eq 422
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to include 'Quantidade de Convidados deve ser menor ou igual a 400'
    end
    it 'and event is not bookable on this date' do
      julia = User.create!(name: 'Julia Kanzaki', email: 'kanzaki@myself.com', password: 'password123', role: 1)
      felipe = User.create!(name: 'Felipe Chineze', email: 'felipe@email.com', password: 'password123', role: 0)
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
        buffet: planalto,
        base_price: 15000.00,
        weekend_fee: 20,
        per_person_fee: 70.00,
        per_person_weekend_fee: 20,
        per_hour_fee: 400.00,
        per_hour_weekend_fee: 50
      )
      order = Order.create!(
        event_date: 12.days.from_now,
        guests_estimation: 300,
        event_details: 'Festa de casamento católico',
        event_address: nil,
        event_type_id: casamento.id,
        user: julia,
        status: 2
      )

      get "/api/v1/event_types/1/available", params: { order: { event_type_id: casamento.id, event_date: 12.days.from_now, guests_estimation: 330 } }
      expect(response.status).to eq 422
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to include 'Data do Evento não está disponível. Por favor, escolha outra data.'
      puts request.fullpath
    end
  end
end

