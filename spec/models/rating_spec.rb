require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe '#presence' do
    it 'of score' do
      rating = Rating.new(score: nil)

      rating.valid?

      result = rating.errors.include?(:score)

      expect(result).to be true
    end
    it 'of review' do
      rating = Rating.new(review: nil)

      rating.valid?

      result = rating.errors.include?(:review)

      expect(result).to be true
    end
  end
  describe '#numericality' do
    context 'only integer' do
      it 'of score - float' do
        rating = Rating.new(score: 3.5)

        rating.valid?

        result = rating.errors.include?(:score)

        expect(result).to be true
      end
      it 'of score - string' do
        rating = Rating.new(score: 'abc')

        rating.valid?

        result = rating.errors.include?(:score)

        expect(result).to be true
      end
    end
  end
  describe '#inclusion' do
    it 'of score - more than 5' do
      rating = Rating.new(score: 6)

      rating.valid?

      result = rating.errors.include?(:score)

      expect(result).to be true
    end
    it 'of score - less than 0' do
      rating = Rating.new(score: -1)

      rating.valid?

      result = rating.errors.include?(:score)

      expect(result).to be true
    end
  end
  describe '#associations' do
    it 'of pictures - has many attached' do
      rating = Rating.new

      expect(rating.pictures).to be_an_instance_of(ActiveStorage::Attached::Many)
    end
  end
end
