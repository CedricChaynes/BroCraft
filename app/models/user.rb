class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :owner_tools, class_name: "Tool", foreign_key: "owner_id"
  has_many :bookings, dependent: :destroy

  validates :username, presence: true, allow_blank: false, uniqueness: true
  validates :first_name, presence: true, allow_blank: false
  validates :last_name, presence: true, allow_blank: false
  validates :email, presence: true, allow_blank: false, uniqueness: true,
                    format: { with: /\A([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-]+\.)+([a-zA-Z]{2,5})\z/}
  validates :password, presence: true, allow_blank: false, length: { minimum: 6 }
  validates :mobile, allow_blank: true,
                     format: { with: /\A((\+33(\s|-)*[1-9])|(0[1-9]))((\s|-)*\d{2}){4}\z/ }
  validates :address, presence: true, allow_blank: false
end
