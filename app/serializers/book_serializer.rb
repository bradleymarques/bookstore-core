class BookSerializer
  include JSONAPI::Serializer

  attribute :title
  attribute :description
  attribute :price_usd

  belongs_to :user
end
