class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :products,    dependent: :destroy

  has_many :buyed_products, foreign_key: "buyer_id", class_name: "Product"
  has_many :saling_products, -> { where("buyer_id is NULL") }, foreign_key: "saler_id", class_name: "Product"
  has_many :sold_products, -> { where("buyer_id is not NULL") }, foreign_key: "saler_id", class_name: "Product"

  has_one :cards, class_name: 'Card'

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,                         presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }, on: :save_step1_to_session
  validates :nickname,                      presence: true, length: {maximum: 20}, on: :save_step1_to_session
  validates :password,                      presence: true, length: {minimum: 6, maximum: 128}, on: :save_step1_to_session
  validates :fullname_kanji,                presence: true, format: {with: /\A[ぁ-んァ-ン一-龥]/}, on: :save_step1_to_session
  validates :fullname_kana,                 presence: true, format: {with: /\A[ぁ-んァ-ヶー－]+\z/}, on: :save_step1_to_session
  validates :birthday,                      presence: true, on: :save_step1_to_session
  validates :current_address_postal_code,   presence: true, format: {with: /\A\d{7}\z/},           on: :save_step2_to_session
  validates :current_address_prefectures,   presence: true, on: :save_step2_to_session
  validates :current_address_city,          presence: true, on: :save_step2_to_session
  validates :current_address,               presence: true, on: :save_step2_to_session
  validates :current_address_building,      presence: true, on: :save_step2_to_session
  validates :tel_number,                    presence: true, format: {with: /\A\d{10,11}\z/}, on: :save_step2_to_session
end
