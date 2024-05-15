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
      user = User.new(name: 'Harry Potter', email: 'harryp@mail.com', role: 1, social_security_number: nil, password: 'password123')

      user.valid?

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
      user = User.new(role: 1, social_security_number: cpf)

      user.valid?
      result = user.errors.include?(:social_security_number)

      expect(result).to be true
    end
  end
  describe '#check_social_security_number' do
    it 'when value is not valid ' do
      user = User.new(role: 1, social_security_number: '66666666666')

      user.valid?
      result = user.errors.include?(:social_security_number)

      expect(result).to be true
    end
  end
  describe '#humanized_role' do
    it 'when role is client' do
      user = User.new(role: 1)

      result = user.humanized_role

      expect(result).to eq('Cliente')
    end
    it 'when role is business_owner' do
      user = User.new(role: 0)

      result = user.humanized_role

      expect(result).to eq('Dono de Buffet')
    end
  end
  describe '#role_options_for_select' do
    it 'returns user roles' do
      result = User.role_options_for_select

      expect(result).to eq([['Dono de Buffet', 'business_owner'], ['Cliente', 'client']])
    end
  end
end
