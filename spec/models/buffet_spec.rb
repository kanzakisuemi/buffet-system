require 'rails_helper'

RSpec.describe Buffet, type: :model do
  describe '#uniqueness' do
    it 'of user that already has a buffet' do
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
    it 'of user that does not have a buffet' do
      kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 0)
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
        zip_code: '123456',
        description: 'Buffet para festas infantis e de adultos',
        user: kylie
      )
      valid_buffet = Buffet.new(
        social_name: 'Buffet da Maria',
        corporate_name: 'Buffet da Maria LTDA',
        company_registration_number: CNPJ.generate,
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
      kendall = User.create!(name: 'Kendall Jenner', email: 'kenny@jenner.com', password: 'password123', role: 0)
      kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
      cnpj = CNPJ.generate
      buffet = Buffet.create!(
        social_name: 'Buffet da Maria',
        corporate_name: 'Buffet da Maria LTDA',
        company_registration_number: cnpj,
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
        company_registration_number: cnpj,
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
      buffet = Buffet.new(social_name: '')

      buffet.valid?
      result = buffet.errors.include?(:social_name)

      expect(result).to be true
    end
    it 'of corporate name' do
      buffet = Buffet.new(corporate_name: '')

      buffet.valid?
      result = buffet.errors.include?(:corporate_name)

      expect(result).to be true
    end
    it 'of company registration number' do
      buffet = Buffet.new(company_registration_number: '')

      buffet.valid?
      result = buffet.errors.include?(:company_registration_number)

      expect(result).to be true
    end
    it 'of phone number' do
      buffet = Buffet.new(phone: '')

      buffet.valid?
      result = buffet.errors.include?(:phone)

      expect(result).to be true
    end
    it 'of email' do
      buffet = Buffet.new(email: '')

      buffet.valid?
      result = buffet.errors.include?(:email)

      expect(result).to be true
    end
    it 'of address' do
      buffet = Buffet.new(address: '')

      buffet.valid?
      result = buffet.errors.include?(:address)

      expect(result).to be true
    end
    it 'of neighborhood' do
      buffet = Buffet.new(neighborhood: '')

      buffet.valid?
      result = buffet.errors.include?(:neighborhood)

      expect(result).to be true
    end
    it 'of city' do
      buffet = Buffet.new(city: '')

      buffet.valid?
      result = buffet.errors.include?(:city)

      expect(result).to be true
    end
    it 'of state' do
      buffet = Buffet.new(state: '')

      buffet.valid?
      result = buffet.errors.include?(:state)

      expect(result).to be true
    end
    it 'of zipcode' do
      buffet = Buffet.new(zip_code: '')

      buffet.valid?
      result = buffet.errors.include?(:zip_code)

      expect(result).to be true
    end
    it 'of description' do
      buffet = Buffet.new(description: '')

      buffet.valid?
      result = buffet.errors.include?(:description)

      expect(result).to be true
    end
    it 'of user' do
      buffet = Buffet.new(user: nil)

      buffet.valid?
      result = buffet.errors.include?(:user)

      expect(result).to be true
    end
  end
  describe '#associations' do
    it 'has many event types' do
      # esperar resposta no mattermost
    end
    it 'has many buffet payments' do
      # esperar resposta no mattermost
    end
    it 'has many payment methods' do
      # esperar resposta no mattermost
    end
    it 'buffet belongs to user - when user is nil' do
      invalid_buffet = Buffet.new(user: nil)

      expect(invalid_buffet).not_to be_valid
    end
    it 'buffet belongs to user - when user is defined' do
      kylie = User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0)
      buffet = Buffet.new(user: kylie)

      buffet.valid?

      expect(buffet.errors.include?(:user)).to be false
    end
  end
end
