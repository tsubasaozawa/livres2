class Product < ApplicationRecord
  belongs_to :user, optional: true
  
  belongs_to :saler, class_name: "User", optional: true
  belongs_to :buyer, class_name: "User", optional: true

  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  has_many :messages, dependent: :destroy

  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images

  validates :images, presence: true
  serialize :categories, JSON
  
end
