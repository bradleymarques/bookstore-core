class Book < ApplicationRecord
  belongs_to :user, required: true

  validates :title, presence: true
  validates :description, presence: true
  validates :price_usd, presence: true

  alias_attribute :author, :user
end
