FactoryBot.define do
  factory(:book) do
    user
    title { Faker::Book.title }
    description { Faker::Book.genre }
    price_usd { Faker::Number.between(from: 1.0, to: 10.0).round(2) }
  end
end
