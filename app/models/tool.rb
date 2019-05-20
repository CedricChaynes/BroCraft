class Tool < ApplicationRecord
  CATEGORY = ['outillage à main', 'outillage électroportatif', 'outillage spécialisé', 'protection', 'équipement de chantier', "machine d'atelier"]
  belongs_to :owner, class_name: "User",
                    foreign_key: "owner_id"
  has_many :bookings

  validates :name, presence: true
  validates :description, presence: true
  validates :price_per_day, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :category, presence: true, inclusion: { in: CATEGORY }
end
