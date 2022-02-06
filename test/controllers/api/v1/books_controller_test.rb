require "test_helper"

module Api
  module V1
    class BooksControllerTest < ActionDispatch::IntegrationTest
      test "an unauthenticated user should be able to successfully #index all books" do
        book_1 = FactoryBot.create(:book)
        book_2 = FactoryBot.create(:book)

        get(api_v1_books_url, as: :json)

        assert(:ok)
      end

      test "an unauthenticated user should be able to successfully #show a single book" do
        book = FactoryBot.create(:book)

        get(api_v1_book_url(book), as: :json)

        assert(:ok)
      end

      test "an unauthenticated user obtains the correct JSON API formatted payload
          when showing a single book" do
        book = FactoryBot.create(:book)
        user = book.user

        get(api_v1_book_url(book), as: :json)

        assert(:ok)

        expected_payload = {
          data: {
            id: book.id,
            type: "book",
            attributes: {
              title: book.title,
              description: book.description,
              price_usd: book.price_usd
            },
            relationships: {
              user: {
                data: {
                  id: user.id,
                  type: "user"
                }
              }
            }
          }
        }.with_indifferent_access

        actual_payload = JSON.parse(response.body).with_indifferent_access

        assert_equal(expected_payload, actual_payload)
      end
    end
  end
end
