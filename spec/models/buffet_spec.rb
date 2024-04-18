require 'rails_helper'

RSpec.describe Buffet, type: :model do
  describe 'is user unique?' do
    it 'false when there is already a buffet' do
      kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
      Buffet.create!(
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
      invalid_buffet = Buffet.new(
        social_name: 'Buffet Coisa Nossa',
        corporate_name: 'Buffet Coisa Nossa LTDA',
        company_registration_number: '12345678910999',
        phone: '996348900',
        email: 'coisa_nossa@email.com',
        address: 'Rua das Angelicas, 1000',
        neighborhood: 'Gleba Palhano',
        city: 'São Paulo',
        state: 'SP',
        zip_code: '123098',
        description: 'Buffet para festas de 15 e universitárias',
        user: kylie
      )

      expect(invalid_buffet).not_to be_valid
    end
    it 'true when there is no buffet' do
      kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
      kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 0)

      Buffet.create!(
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

      valid_buffet = Buffet.new(
        social_name: 'Buffet da Maria',
        corporate_name: 'Buffet da Maria LTDA',
        company_registration_number: '12345678910667',
        phone: '996344500',
        email: 'maria@email.com',
        address: 'Rua das Flores, 230',
        neighborhood: 'Jardim das Flores',
        city: 'São Paulo',
        state: 'SP',
        zip_code: '123456',
        description: 'Buffet para festas infantis e de adultos',
        user: kendall
      )

      expect(valid_buffet).to be_valid
    end
  end
  describe 'is company registration number unique?' do
    it 'false when there is already a company with same registration number' do
      kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
      kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 0)

      Buffet.create!(
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
      invalid_buffet = Buffet.new(
        social_name: 'Buffet Coisa Nossa',
        corporate_name: 'Buffet Coisa Nossa LTDA',
        company_registration_number: '12345678910111',
        phone: '996348900',
        email: 'coisa_nossa@email.com',
        address: 'Rua das Angelicas, 1000',
        neighborhood: 'Gleba Palhano',
        city: 'São Paulo',
        state: 'SP',
        zip_code: '123098',
        description: 'Buffet para festas de 15 e universitárias',
        user: kendall
      )

      expect(invalid_buffet).not_to be_valid
    end
  end
  describe 'are all fields filled?' do
    it 'false when there is a blank field' do
      kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
      invalid_buffet = Buffet.new(
        social_name: 'Buffet Coisa Nossa',
        corporate_name: 'Buffet Coisa Nossa LTDA',
        company_registration_number: '',
        phone: '996348900',
        email: 'coisa_nossa@email.com',
        address: 'Rua das Angelicas, 1000',
        neighborhood: 'Gleba Palhano',
        city: 'São Paulo',
        state: 'SP',
        zip_code: '123098',
        description: 'Buffet para festas de 15 e universitárias',
        user: kylie
      )

      expect(invalid_buffet).not_to be_valid
    end
  end
end
