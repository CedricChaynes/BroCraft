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

  def bookable?(start_date, end_date)
    if bookings.empty?
      true
    else
      checkings = bookings.map do |book|
        (book.end_date.between?(start_date, end_date) ||
        book.start_date.between?(start_date, end_date))
      end
      checkings.any? == false
    end
  end

  def self.search(params)
    results = if params[:name].present? && params[:name].present?
                where('name ILIKE ?', "%#{params[:name]}%")
                  .where('category ILIKE ?', "%#{params[:category]}%")
              elsif params[:name].present?
                where('name ILIKE ?', "%#{params[:name]}%")
              elsif params[:category].present?
                where('category ILIKE ?', "%#{params[:category]}%")
              else
                all
              end

    start_date = params[:start_date] || Date.today
    end_date = params[:end_date] || Date.today
    results = results.select { |elem| elem.bookable?(start_date, end_date) }
    return results
  end

  def downcase_input
    category.downcase!
  end
end
