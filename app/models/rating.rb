class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :buffet
  has_many_attached :pictures

  validates :score, :review, :user, presence: true
  validates :score, numericality: { only_integer: true }
  validates :score, inclusion: { in: 0..5 }

  def pictures_as_thumbnails
    pictures.map do |picture|
      picture.variant(resize: '400x400^', gravity: 'Center', extent: '400x400').processed
    end
  end
end
