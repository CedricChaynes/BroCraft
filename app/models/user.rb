class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :owner_tools, class_name: "Tool", foreign_key: "owner_id"
  has_many :bookings, dependent: :destroy

  validates :username, presence: true, allow_blank: false, uniqueness: true
  validates :mobile, format: { with: /\A((((\+33)|(\(\+33\)))(\s|-)*[1-9])|(0[1-9]))((\s|-)*\d{2}){4}\z/ }
  validates :address, presence: true, allow_blank: false
  mount_uploader :avatar, PhotoUploader
end
