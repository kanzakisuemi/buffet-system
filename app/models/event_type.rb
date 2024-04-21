class EventType < ApplicationRecord
  belongs_to :buffet

  validates :category, :name, :description, :minimal_people_capacity, :maximal_people_capacity, :default_duration_minutes, :food_menu, presence: true

  enum category: %i[corporate graduation wedding birthday other]

  def humanized_category
    I18n.t("activerecord.attributes.event_type.categories.#{category}", payment_type: self)
  end

  def self.category_options_for_select
    categories.map do |category, _|
      [I18n.t("activerecord.attributes.event_type.categories.#{category}"), category]
    end
  end
end
