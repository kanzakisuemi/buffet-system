require 'rails_helper'

RSpec.describe Buffet, type: :model do
  describe '#format' do
    it 'email - w/out @' do
      buffet = Buffet.new(email: 'abcabc.com')

      buffet.valid?
      result = buffet.errors.include?(:email)

      expect(result).to be true
    end
  end
  describe '#numericality' do
    it 'of phone' do
      buffet = Buffet.new(phone: 'abcdefghij')

      buffet.valid?
      result = buffet.errors.include?(:phone)

      expect(result).to be true
    end
    it 'of events per day' do
      buffet = Buffet.new(events_per_day: 'abc')

      buffet.valid?
      result = buffet.errors.include?(:events_per_day)

      expect(result).to be true
    end
    it 'of zipcode' do
      buffet = Buffet.new(zip_code: 'abcdefgh')

      buffet.valid?
      result = buffet.errors.include?(:zip_code)

      expect(result).to be true
    end
  end
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
        zip_code: '12345678',
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
        zip_code: '12345678',
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
        zip_code: '12345678',
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
        zip_code: '12345678',
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
        zip_code: '12345678',
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
    it 'of events per day' do
      buffet = Buffet.new(events_per_day: nil)

      buffet.valid?
      result = buffet.errors.include?(:events_per_day)

      expect(result).to be true
    end
  end
  describe '#length' do
    it 'of phone number - too short' do
      buffet = Buffet.new(phone: '1234567')

      buffet.valid?
      result = buffet.errors.include?(:phone)

      expect(result).to be true
    end
    it 'of phone number - too long' do
      buffet = Buffet.new(phone: '123456789012345')

      buffet.valid?
      result = buffet.errors.include?(:phone)

      expect(result).to be true
    end
    it 'of zipcode - too short' do
      buffet = Buffet.new(zip_code: '123456')

      buffet.valid?
      result = buffet.errors.include?(:zip_code)

      expect(result).to be true
    end
    it 'of zipcode - too long' do
      buffet = Buffet.new(zip_code: '123456789')

      buffet.valid?
      result = buffet.errors.include?(:zip_code)

      expect(result).to be true
    end
    it 'of state - too short' do
      buffet = Buffet.new(state: 'A')

      buffet.valid?
      result = buffet.errors.include?(:state)

      expect(result).to be true
    end
    it 'of state - too long' do
      buffet = Buffet.new(state: 'ABC')

      buffet.valid?
      result = buffet.errors.include?(:state)

      expect(result).to be true
    end
  end
  describe '#associations' do
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
  describe '#check_company_registration_number' do
    it 'when company registration number is invalid' do
      buffet = Buffet.new(company_registration_number: '12345678910999')

      buffet.valid?
      result = buffet.errors.include?(:company_registration_number)

      expect(result).to be true
    end
    it 'when company registration number is valid' do
      buffet = Buffet.new(company_registration_number: CNPJ.generate)

      buffet.valid?
      result = buffet.errors.include?(:company_registration_number)

      expect(result).to be false
    end
  end
  describe '#rating_average' do
    it 'when buffet has 3 ratings' do
      felca = User.create!(name: 'Felipe Bressanim', email: 'felca@youtuber.com', password: 'password123', role: 1, social_security_number: CPF.generate)
      orochinho = User.create!(name: 'Pedro Orochi', email: 'pedro@mail.com', password: 'password123', role: 1, social_security_number: CPF.generate)
      matheus = User.create!(name: 'Matheus Bellucio', email: 'belluciom@mail.com', password: 'password123', role: 1, social_security_number: CPF.generate)
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
        zip_code: '12345678',
        description: 'Buffet para festas infantis e de adultos',
        user: kylie,
        payment_methods: [ ]
      )
      Rating.create!(score: 3, review: 'Achei que não foi bacana.', buffet: buffet, user: matheus)
      Rating.create!(score: 4, review: 'Achei bem bacana.', buffet: buffet, user: felca)
      Rating.create!(score: 2, review: 'Achei bem esquisito o evento.', buffet: buffet, user: orochinho)

      result = buffet.rating_average

      expect(result).to eq(3)
    end
  end
end
