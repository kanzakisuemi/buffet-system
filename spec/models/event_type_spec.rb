require 'rails_helper'

RSpec.describe EventType, type: :model do
  describe '#category_options_for_select' do
    it 'returns categories' do
      result = EventType.category_options_for_select

      expect(result).to eq([['Corporativo', 'corporate'], ['Formatura', 'graduation'], ['Casamento', 'wedding'], ['Aniversário', 'birthday'], ['Outro', 'other']])
    end
  end
  describe '#humanized_category' do
    it 'returns humanized category' do
      event_type = EventType.new(category: :corporate)

      result = event_type.humanized_category

      expect(result).to eq('Corporativo')
    end
  end
  describe '#apply_fee' do
    it 'applies fee to value' do
      event_type = EventType.new
      value = 100
      fee_percentage = 10

      result = event_type.apply_fee(value, fee_percentage)

      expect(result).to eq(110)
    end
  end
  describe '#presence' do
    it 'of category' do
      event_type = EventType.new(category: nil)

      event_type.valid?
      result = event_type.errors.include?(:category)

      expect(result).to be true
    end
    it 'of name' do
      event_type = EventType.new(name: nil)

      event_type.valid?
      result = event_type.errors.include?(:name)

      expect(result).to be true
    end
    it 'of description' do
      event_type = EventType.new(description: nil)

      event_type.valid?
      result = event_type.errors.include?(:description)

      expect(result).to be true
    end
    it 'of minimal people capacity' do
      event_type = EventType.new(minimal_people_capacity: nil)

      event_type.valid?
      result = event_type.errors.include?(:minimal_people_capacity)

      expect(result).to be true
    end
    it 'of maximal people capacity' do
      event_type = EventType.new(maximal_people_capacity: nil)

      event_type.valid?
      result = event_type.errors.include?(:maximal_people_capacity)

      expect(result).to be true
    end
    it 'of default duration in minutes' do
      event_type = EventType.new(default_duration_minutes: nil)

      event_type.valid?
      result = event_type.errors.include?(:default_duration_minutes)

      expect(result).to be true
    end
    it 'of food menu' do
      event_type = EventType.new(food_menu: nil)

      event_type.valid?
      result = event_type.errors.include?(:food_menu)

      expect(result).to be true
    end
    it 'of base price' do
      event_type = EventType.new(base_price: nil)

      event_type.valid?
      result = event_type.errors.include?(:base_price)

      expect(result).to be true
    end
    it 'of weekend fee' do
      event_type = EventType.new(weekend_fee: nil)

      event_type.valid?
      result = event_type.errors.include?(:weekend_fee)

      expect(result).to be true
    end
    it 'of per person fee' do
      event_type = EventType.new(per_person_fee: nil)

      event_type.valid?
      result = event_type.errors.include?(:per_person_fee)

      expect(result).to be true
    end
    it 'of per person weekend fee' do
      event_type = EventType.new(per_person_weekend_fee: nil)

      event_type.valid?
      result = event_type.errors.include?(:per_person_weekend_fee)

      expect(result).to be true
    end
    it 'of per hour fee' do
      event_type = EventType.new(per_hour_fee: nil)

      event_type.valid?
      result = event_type.errors.include?(:per_hour_fee)

      expect(result).to be true
    end
    it 'of per hour weekend fee' do
      event_type = EventType.new(per_hour_weekend_fee: nil)

      event_type.valid?
      result = event_type.errors.include?(:per_hour_weekend_fee)

      expect(result).to be true
    end
  end
  describe '#numericality' do
    it 'of minimal people capacity - not a number' do
      event_type = EventType.new(minimal_people_capacity: 'abc')

      event_type.valid?
      result = event_type.errors.include?(:minimal_people_capacity)

      expect(result).to be true
    end
    it 'of maximal people capacity - not a number' do
      event_type = EventType.new(maximal_people_capacity: 'abc')

      event_type.valid?
      result = event_type.errors.include?(:maximal_people_capacity)

      expect(result).to be true
    end
    it 'of minimal people capacity - negative number' do
      event_type = EventType.new(minimal_people_capacity: -1)

      event_type.valid?
      result = event_type.errors.include?(:minimal_people_capacity)

      expect(result).to be true
    end
    it 'of maximal people capacity - negative number' do
      event_type = EventType.new(maximal_people_capacity: -1)

      event_type.valid?
      result = event_type.errors.include?(:maximal_people_capacity)

      expect(result).to be true
    end
    it 'of default duration in minutes - not a number' do
      event_type = EventType.new(default_duration_minutes: 'abc')

      event_type.valid?
      result = event_type.errors.include?(:default_duration_minutes)

      expect(result).to be true
    end  
    it 'of weekend fee - not a number' do
      event_type = EventType.new(weekend_fee: 'abc')

      event_type.valid?
      result = event_type.errors.include?(:weekend_fee)

      expect(result).to be true
    end
    it 'of per person weekend fee - not a number' do
      event_type = EventType.new(per_person_weekend_fee: 'abc')

      event_type.valid?
      result = event_type.errors.include?(:per_person_weekend_fee)

      expect(result).to be true
    end
    it 'of per hour weekend fee - not a number' do
      event_type = EventType.new(per_hour_weekend_fee: 'abc')

      event_type.valid?
      result = event_type.errors.include?(:per_hour_weekend_fee)

      expect(result).to be true
    end
  end
  describe '#less_than_or_equal_to' do
    it 'of weekend fee - greater than 100' do
      event_type = EventType.new(weekend_fee: 101)

      event_type.valid?
      result = event_type.errors.include?(:weekend_fee)

      expect(result).to be true
    end
    it 'of per person weekend fee - greater than 100' do
      event_type = EventType.new(per_person_weekend_fee: 101)

      event_type.valid?
      result = event_type.errors.include?(:per_person_weekend_fee)

      expect(result).to be true
    end
    it 'of per hour weekend fee - greater than 100' do
      event_type = EventType.new(per_hour_weekend_fee: 101)

      event_type.valid?
      result = event_type.errors.include?(:per_hour_weekend_fee)

      expect(result).to be true
    end
  end
  describe '#associations' do
    it 'of pictures - has many attached' do
      event_type = EventType.new

      expect(event_type.pictures).to be_an_instance_of(ActiveStorage::Attached::Many)
    end
    it '' do
    end
  end
end
