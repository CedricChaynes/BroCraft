class Tool < ApplicationRecord
  CATEGORIES = ['Outillage à main', 'Outillage électroportatif',
                'Outillage spécialisé', 'Protection', 'Équipement de chantier',
                "Machine d'atelier"]

  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  has_many :bookings, dependent: :destroy
  before_validation :downcase_input

  validates :name, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: false
  validates :owner_id, presence: true, allow_blank: false
  validates :price_per_day, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :category, presence: true, inclusion: { in: CATEGORIES.map(&:downcase) }
  mount_uploader :photo, PhotoUploader

  def self.search(params)
    if params[:name].present? && params[:name].present?
      where('name ILIKE ?', "%#{params[:name]}%")
        .where('category ILIKE ?', "%#{params[:category]}%")
    elsif params[:name].present?
      where('name ILIKE ?', "%#{params[:name]}%")
    elsif params[:category].present?
      where('category ILIKE ?', "%#{params[:category]}%")
    else
      all
    end
  end

  def downcase_input
    category.downcase!
  end
end
