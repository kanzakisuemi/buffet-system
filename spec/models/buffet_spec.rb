require 'rails_helper'

RSpec.describe Buffet, type: :model do

  let(:kylie) { User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0) }
  let(:kendall) { User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 0) }
  let(:buffet) {
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
  }

  describe '#uniqueness' do
    it 'of user that already has a buffet' do
      buffet
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
    it 'of user that does not have a buffet' do
      buffet

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
    it 'of company registration number that is already linked to a buffet' do
      buffet
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
  describe '#presence' do
    it 'of social name' do
      invalid_buffet = Buffet.new(
        social_name: nil,
        corporate_name: 'Buffet Coisa Nossa LTDA',
        company_registration_number: '99992286548384',
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
    it 'of corporate name' do
      invalid_buffet = Buffet.new(
        social_name: 'Buffet Coisa Nossa',
        corporate_name: nil,
        company_registration_number: '99992286548384',
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
    it 'of company registration number' do
      invalid_buffet = Buffet.new(
        social_name: 'Buffet Coisa Nossa',
        corporate_name: 'Buffet Coisa Nossa LTDA',
        company_registration_number: nil,
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
    it 'of phone number' do
      invalid_buffet = Buffet.new(
        social_name: 'Buffet Coisa Nossa',
        corporate_name: 'Buffet Coisa Nossa LTDA',
        company_registration_number: '99992286548384',
        phone: nil,
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
    it 'of email' do
      invalid_buffet = Buffet.new(
        social_name: 'Buffet Coisa Nossa',
        corporate_name: 'Buffet Coisa Nossa LTDA',
        company_registration_number: '99992286548384',
        phone: '996348900',
        email: nil,
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
    it 'of address' do
      invalid_buffet = Buffet.new(
        social_name: 'Buffet da Maria',
        corporate_name: 'Buffet da Maria LTDA',
        company_registration_number: '12345678910111',
        phone: '996348000',
        email: 'maria@email.com',
        address: nil,
        neighborhood: 'Jardim das Flores',
        city: 'São Paulo',
        state: 'SP',
        zip_code: '123456',
        description: 'Buffet para festas infantis e de adultos',
        user: kylie
      )

      expect(invalid_buffet).not_to be_valid
    end
    it 'of neighborhood' do
      invalid_buffet = Buffet.new(
        social_name: 'Buffet da Maria',
        corporate_name: 'Buffet da Maria LTDA',
        company_registration_number: '12345678910111',
        phone: '996348000',
        email: 'maria@email.com',
        address: 'Rua das Flores, 230',
        neighborhood: nil,
        city: 'São Paulo',
        state: 'SP',
        zip_code: '123456',
        description: 'Buffet para festas infantis e de adultos',
        user: kylie
      )

      expect(invalid_buffet).not_to be_valid
    end
    it 'of city' do
      invalid_buffet = Buffet.new(
        social_name: 'Buffet da Maria',
        corporate_name: 'Buffet da Maria LTDA',
        company_registration_number: '12345678910111',
        phone: '996348000',
        email: 'maria@email.com',
        address: 'Rua das Flores, 230',
        neighborhood: 'Jardim das Flores',
        city: nil,
        state: 'SP',
        zip_code: '123456',
        description: 'Buffet para festas infantis e de adultos',
        user: kylie
      )

      expect(invalid_buffet).not_to be_valid
    end
    it 'of state' do
      invalid_buffet = Buffet.new(
        social_name: 'Buffet da Maria',
        corporate_name: 'Buffet da Maria LTDA',
        company_registration_number: '12345678910111',
        phone: '996348000',
        email: 'maria@email.com',
        address: 'Rua das Flores, 230',
        neighborhood: 'Jardim das Flores',
        city: 'São Paulo',
        state: nil,
        zip_code: '123456',
        description: 'Buffet para festas infantis e de adultos',
        user: kylie
      )

      expect(invalid_buffet).not_to be_valid
    end
    it 'of zipcode' do
      invalid_buffet = Buffet.new(
        social_name: 'Buffet da Maria',
        corporate_name: 'Buffet da Maria LTDA',
        company_registration_number: '12345678910111',
        phone: '996348000',
        email: 'maria@email.com',
        address: 'Rua das Flores, 230',
        neighborhood: 'Jardim das Flores',
        city: 'São Paulo',
        state: 'SP',
        zip_code: nil,
        description: 'Buffet para festas infantis e de adultos',
        user: kylie
      )

      expect(invalid_buffet).not_to be_valid
    end
    it 'of description' do
      invalid_buffet = Buffet.new(
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
        description: nil,
        user: kylie
      )

      expect(invalid_buffet).not_to be_valid
    end
    it 'of user' do
      invalid_buffet = Buffet.new(
        social_name: 'Buffet Coisa Nossa',
        corporate_name: 'Buffet Coisa Nossa LTDA',
        company_registration_number: '99992286548384',
        phone: '996348900',
        email: 'coisa_nossa@email.com',
        address: 'Rua das Angelicas, 1000',
        neighborhood: 'Gleba Palhano',
        city: 'São Paulo',
        state: 'SP',
        zip_code: '123098',
        description: 'Buffet para festas de 15 e universitárias',
        user: nil
      )

      expect(invalid_buffet).not_to be_valid
    end
  end
end
