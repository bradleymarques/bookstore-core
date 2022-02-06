require "test_helper"

class BookSerializerTest < ActiveSupport::TestCase
  test "can serialize a Book with expected attributes as well as the
      relationship to the User/Author" do
    title = "Man's search for Meaning"
    description = "... some description ..."
    price_usd = 9.75

    book = FactoryBot.create(
      :book,
      title: title,
      description: description,
      price_usd: price_usd
    )

    user = book.user

    book_serializer = BookSerializer.new(book)

    expected_hash = {
      data: {
        id: book.id,
        type: :book,
        attributes: {
          title: title,
          description: description,
          price_usd: price_usd
        },
        relationships: {
          user: {
            data: {
              id: user.id,
              type: :user
            }
          }
        }
      }
    }

    actual_hash = book_serializer.serializable_hash

    assert_equal(expected_hash, actual_hash)
  end
end
