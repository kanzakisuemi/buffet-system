class EventType < ApplicationRecord
  belongs_to :buffet
  has_many_attached :pictures
  has_many :orders

  validates :category, :name, :description, :minimal_people_capacity, :maximal_people_capacity, :default_duration_minutes, :food_menu, presence: true
  validates :base_price, :weekend_fee, :per_person_fee, :per_person_weekend_fee, :per_hour_fee, :per_hour_weekend_fee, presence: true
  validates :minimal_people_capacity, :maximal_people_capacity, :default_duration_minutes, numericality: { only_integer: true, greater_than: 0 }
  validates :weekend_fee, :per_person_weekend_fee, :per_hour_weekend_fee, numericality: { only_integer: true }
  validates :weekend_fee, :per_person_weekend_fee, :per_hour_weekend_fee, numericality: { less_than_or_equal_to: 100 }

  enum category: %i[corporate graduation wedding birthday other]

  def apply_fee(value, fee_percentage)
    fee_amount = value * (fee_percentage.to_f / 100)
    value_with_fee = value + fee_amount
    return value_with_fee
  end

  def pictures_as_thumbnails
    pictures.map do |picture|
      picture.variant(resize: '400x400^', gravity: 'Center', extent: '400x400').processed
    end
  end

  def resize(picture)
    picture.variant(resize_to_limit: [150, 150]).processed
  end

  def humanized_category
    I18n.t("activerecord.attributes.event_type.categories.#{category}", payment_type: self)
  end

  def self.category_options_for_select
    categories.map do |category, _|
      [I18n.t("activerecord.attributes.event_type.categories.#{category}"), category]
    end
  end
end
