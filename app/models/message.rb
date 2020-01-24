class Message < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :message, presence: true
end
