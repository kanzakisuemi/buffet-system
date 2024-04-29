require 'rails_helper'

RSpec.describe EventType, type: :model do
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
  end
  describe '#has_many_attached' do
    it 'pictures' do
      event_type = EventType.new

      expect(event_type.pictures).to be_an_instance_of(ActiveStorage::Attached::Many)
    end
  end
end
