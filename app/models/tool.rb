class Tool < ApplicationRecord
  CATEGORIES = ['outillage à main', 'outillage électroportatif',
                'outillage spécialisé', 'protection', 'équipement de chantier',
                "machine d'atelier"]

  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  has_many :bookings, dependent: :destroy

  validates :name, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: false
  validates :owner_id, presence: true, allow_blank: false
  validates :price_per_day, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :category, presence: true, inclusion: { in: CATEGORIES }
end
