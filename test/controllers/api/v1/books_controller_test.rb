require "test_helper"

module Api
  module V1
    class BooksControllerTest < ActionDispatch::IntegrationTest
      test "an unauthenticated user should be able to #index all books" do
        book_1 = FactoryBot.create(:book)
        book_2 = FactoryBot.create(:book)

        get(api_v1_books_url, as: :json)

        assert(:ok)
      end
    end
  end
end
