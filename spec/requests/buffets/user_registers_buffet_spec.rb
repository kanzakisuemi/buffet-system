require 'rails_helper'

describe 'user tries to register buffet' do
  it 'and fails - as client' do
    kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
    
    login_as(kendall)
    post buffets_path, params: { buffet: { social_name: 'buffet fake', corporate_name: 'buffet fake ltda', company_registration_number: '52435354311', phone: '43998248585', email: 'buffet@email.com', address: 'Rua Inexistente, 300', neighborhood: 'Jardim dos Sonhos', city: 'Londrina', state: 'PR', zip_code: '85044190', description: 'buffet totalmente fake', user: kendall } }
    
    expect(response).to redirect_to root_path
  end
  it 'and fails - as visitor' do
    post buffets_path, params: { buffet: { social_name: 'buffet fake', corporate_name: 'buffet fake ltda', company_registration_number: '52435354311', phone: '43998248585', email: 'buffet@email.com', address: 'Rua Inexistente, 300', neighborhood: 'Jardim dos Sonhos', city: 'Londrina', state: 'PR', zip_code: '85044190', description: 'buffet totalmente fake' } } 
    
    expect(response).to redirect_to root_path
  end
end
