require 'rails_helper'

describe 'user tries to access' do
  it 'buffets orders - as visitor' do
    get orders_path
    expect(response).to redirect_to root_path
  end
  it 'buffets orders - as client' do
    kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
    login_as(kendall)

    get orders_path
    expect(response).to redirect_to root_path 
  end
  it 'my orders - as visitor' do
    get my_orders_path
    expect(response).to redirect_to root_path
  end
  it 'my orders - as business owner' do
    get my_orders_path
    expect(response).to redirect_to root_path
  end
end
