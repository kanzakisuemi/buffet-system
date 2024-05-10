require 'rails_helper'

describe 'user tries to register an event type' do
  it 'and fails - as client' do
    kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
    login_as(kendall)
    post event_types_path, params: { event_type: { name: 'evento fake', description: 'um evento fake', minimal_people_capacity: 50, maximal_people_capacity: 70, default_duration_minutes: 120, food_menu: 'camarao e shitake', alcoholic_drinks: true, decoration: true, parking_service: false, location_flexibility: true } }
    
    expect(response).to redirect_to root_path
  end
  it 'and fails - as visitor' do
    post event_types_path, params: { event_type: { name: 'evento fake', description: 'um evento fake', minimal_people_capacity: 50, maximal_people_capacity: 70, default_duration_minutes: 120, food_menu: 'camarao e shitake', alcoholic_drinks: true, decoration: true, parking_service: false, location_flexibility: true } }
    
    expect(response).to redirect_to root_path
  end
end
