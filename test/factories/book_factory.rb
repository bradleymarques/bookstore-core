FactoryBot.define do
  factory(:book) do
    user
    title { "title" }
    description { "description" }
    price_usd { 10.00 }
  end
end
