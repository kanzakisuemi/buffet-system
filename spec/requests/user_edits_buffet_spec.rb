require 'rails_helper'

describe 'user tries to edit a buffet' do
  it 'and fails - as client' do
    kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 1, social_security_number: CPF.generate)
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
    buffet = Buffet.create!(
      social_name: 'Buffet da Maria',
      corporate_name: 'Buffet da Maria LTDA',
      company_registration_number: '12345678910111',
      phone: '996348000',
      email: 'maria@email.com',
      address: 'Rua das Flores, 230',
      neighborhood: 'Jardim das Flores',
      city: 'São Paulo',
      state: 'SP',
      zip_code: '123456',
      description: 'Buffet para festas infantis e de adultos',
      user: kylie
    )

    login_as(kendall)
    patch buffet_path(buffet), params: { buffet: { social_name: 'Buffet da Joana', corporate_name: 'Buffet da Maria LTDA', company_registration_number: '12345678910111', phone: '996348000', email: 'maria@email.com', address: 'Rua das Flores, 230', neighborhood: 'Jardim das Flores', city: 'São Paulo', state: 'SP', zip_code: '123456', description: 'Buffet para festas infantis e de adultos', user: kylie } }

    expect(response).to redirect_to root_path
  end
  it 'and fails - as visitor' do
    kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
    buffet = Buffet.create!(
      social_name: 'Buffet da Maria',
      corporate_name: 'Buffet da Maria LTDA',
      company_registration_number: '12345678910111',
      phone: '996348000',
      email: 'maria@email.com',
      address: 'Rua das Flores, 230',
      neighborhood: 'Jardim das Flores',
      city: 'São Paulo',
      state: 'SP',
      zip_code: '123456',
      description: 'Buffet para festas infantis e de adultos',
      user: kylie
    )

    patch buffet_path(buffet), params: { buffet: { social_name: 'Buffet da Joana', corporate_name: 'Buffet da Maria LTDA', company_registration_number: '12345678910111', phone: '996348000', email: 'maria@email.com', address: 'Rua das Flores, 230', neighborhood: 'Jardim das Flores', city: 'São Paulo', state: 'SP', zip_code: '123456', description: 'Buffet para festas infantis e de adultos', user: kylie } }

    expect(response).to redirect_to root_path
  end
end
