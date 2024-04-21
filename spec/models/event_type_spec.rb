require 'rails_helper'

RSpec.describe EventType, type: :model do
    
  let(:kylie) { User.create!(name: 'Kylie Kristen Jenner', email: 'khy@jenner.com', password: 'password123', role: 0) }
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

  describe '#presence' do
    it 'of category' do
      invalid_event_type = EventType.new(
        category: nil,
        name: 'Casamento de Pets',
        description: 'Casamento de animais de estimação convencionais',
        minimal_people_capacity: 10,
        maximal_people_capacity: 30,
        default_duration_minutes: 120,
        food_menu: 'Petiscos e cupcakes orgânicos',
        alcoholic_drinks: false,
        parking_service: false,
        decoration: true,
        location_flexibility: true,
        buffet: kylie.buffet
      )
      expect(invalid_event_type).not_to be_valid
    end
    it 'of name' do
      invalid_event_type = EventType.new(
        category: 2,
        name: nil,
        description: 'Casamento de animais de estimação convencionais',
        minimal_people_capacity: 10,
        maximal_people_capacity: 30,
        default_duration_minutes: 120,
        food_menu: 'Petiscos e cupcakes orgânicos',
        alcoholic_drinks: false,
        parking_service: false,
        decoration: true,
        location_flexibility: true,
        buffet: kylie.buffet
      )
      expect(invalid_event_type).not_to be_valid
    end
    it 'of description' do
      invalid_event_type = EventType.new(
        category: 2,
        name: 'Casamento de Pets',
        description: nil,
        minimal_people_capacity: 10,
        maximal_people_capacity: 30,
        default_duration_minutes: 120,
        food_menu: 'Petiscos e cupcakes orgânicos',
        alcoholic_drinks: false,
        parking_service: false,
        decoration: true,
        location_flexibility: true,
        buffet: kylie.buffet
      )
      expect(invalid_event_type).not_to be_valid
    end
    it 'of minimal people capacity' do
      invalid_event_type = EventType.new(
        category: 2,
        name: 'Casamento de Pets',
        description: 'Casamento de animais de estimação convencionais',
        minimal_people_capacity: nil,
        maximal_people_capacity: 30,
        default_duration_minutes: 120,
        food_menu: 'Petiscos e cupcakes orgânicos',
        alcoholic_drinks: false,
        parking_service: false,
        decoration: true,
        location_flexibility: true,
        buffet: kylie.buffet
      )
      expect(invalid_event_type).not_to be_valid
    end
    it 'of maximal people capacity' do
      invalid_event_type = EventType.new(
        category: 2,
        name: 'Casamento de Pets',
        description: 'Casamento de animais de estimação convencionais',
        minimal_people_capacity: 10,
        maximal_people_capacity: nil,
        default_duration_minutes: 120,
        food_menu: 'Petiscos e cupcakes orgânicos',
        alcoholic_drinks: false,
        parking_service: false,
        decoration: true,
        location_flexibility: true,
        buffet: kylie.buffet
      )
      expect(invalid_event_type).not_to be_valid
    end
    it 'of default duration in minutes' do
      invalid_event_type = EventType.new(
        category: 2,
        name: 'Casamento de Pets',
        description: 'Casamento de animais de estimação convencionais',
        minimal_people_capacity: 10,
        maximal_people_capacity: 30,
        default_duration_minutes: nil,
        food_menu: 'Petiscos e cupcakes orgânicos',
        alcoholic_drinks: false,
        parking_service: false,
        decoration: true,
        location_flexibility: true,
        buffet: kylie.buffet
      )
      expect(invalid_event_type).not_to be_valid
    end
    it 'of food menu' do
      invalid_event_type = EventType.new(
        category: 2,
        name: 'Casamento de Pets',
        description: 'Casamento de animais de estimação convencionais',
        minimal_people_capacity: 10,
        maximal_people_capacity: 30,
        default_duration_minutes: 120,
        food_menu: nil,
        alcoholic_drinks: false,
        parking_service: false,
        decoration: true,
        location_flexibility: true,
        buffet: kylie.buffet
      )
      expect(invalid_event_type).not_to be_valid
    end
  end
end
