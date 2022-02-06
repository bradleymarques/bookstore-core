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

      test "an unauthenticated user obtains the correct JSON API formatted payload
          when indexing multiple books" do
        title_1 = "Book A"
        title_2 = "Book B"

        book_1 = FactoryBot.create(:book, title: title_1)
        user_1 = book_1.user
        book_2 = FactoryBot.create(:book, title: title_2)
        user_2 = book_2.user

        get(api_v1_books_url, as: :json)

        assert(:ok)

        expected_payload = {
          data: [
            {
              id: book_1.id,
              type: "book",
              attributes: {
                title: book_1.title,
                description: book_1.description,
                price_usd: book_1.price_usd
              },
              relationships: {
                user: {
                  data: {
                    id: user_1.id,
                    type: "user"
                  }
                }
              }
            },
            {
              id: book_2.id,
              type: "book",
              attributes: {
                title: book_2.title,
                description: book_2.description,
                price_usd: book_2.price_usd
              },
              relationships: {
                user: {
                  data: {
                    id: user_2.id,
                    type: "user"
                  }
                }
              }
            }
          ]
        }.with_indifferent_access

        actual_payload = JSON.parse(response.body).with_indifferent_access

        assert_equal(expected_payload, actual_payload)
      end

      test "an unauthenticated user cannot #create a new Book" do
        user = FactoryBot.create(:user)

        params = {
            book: {
            title: "My new Book",
            description: "This is my latest book...",
            price_usd: 5.0
          }
        }

        post(api_v1_books_path, params: params, as: :json)
        assert_response(:forbidden)
      end

      test "an authenticated user can #create a new Book" do
        user = FactoryBot.create(:user)

        params = {
            book: {
            title: "My new Book",
            description: "This is my latest book...",
            price_usd: 5.0
          }
        }

        post(
          api_v1_books_path,
          params: params,
          as: :json,
          headers: authentication_header(user)
        )

        assert_response(:created)
      end

      private

      def authentication_header(user, expiry_time_minutes = 5)
        payload = {
          "iss": "melio.ai",
          "exp": expiry_time_minutes.minutes.from_now.to_i,
          "username": user.username,
        }

        encoded_header = JWT.encode(
          payload,
          Rails.application.credentials.jwt_secret,
          "HS256"
        )

        { ApplicationController::AUTH_HEADER => encoded_header }
      end
    end
  end
end
