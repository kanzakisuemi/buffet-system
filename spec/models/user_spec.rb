require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#presence' do
    it 'of role' do
      user = User.new(role: nil)

      user.valid?
      result = user.errors.include?(:role)

      expect(result).to be true
    end
    it 'of name' do
      user = User.new(name: nil)

      user.valid?
      result = user.errors.include?(:name)

      expect(result).to be true
    end
    it 'of social security number if user is a client' do
      user = User.create!(name: 'Harry Potter', email: 'harryp@mail.com', role: 1, social_security_number: nil, password: 'password123')

      user.update(social_security_number: nil)

      result = user.errors.include?(:social_security_number)
      expect(result).to be true
    end
    it 'of social security number if user is a business owner' do
      business_owner = User.new(role: 0, social_security_number: nil)

      business_owner.valid?

      result = business_owner.errors.include?(:social_security_number)

      expect(result).to be false
    end
  end
  describe '#uniqueness' do
    it 'of social security number if user is a client' do
      cpf = CPF.generate
      User.create!(name: 'Harry Potter', email: 'harryp@mail.com', role: 1, social_security_number: cpf, password: 'password123')
      user = User.create!(name: 'Hermione Granger', email: 'hermione@mail.com', role: 1, password: 'password123')
      user.social_security_number = cpf

      user.valid?
      result = user.errors.include?(:social_security_number)

      expect(result).to be true
    end
  end 
end
