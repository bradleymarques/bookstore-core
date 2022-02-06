module Api
  module V1
    class BooksController < ApplicationController
      def index
        respond_to do |format|
          format.json do
            books = Book.all.order(:title)
            serializer = BookSerializer.new(books)

            render(status: :ok, json: serializer.serializable_hash)
          end
        end
      end

      def show
        respond_to do |format|
          format.json do
            book = Book.find(params.require(:id))
            serializer = BookSerializer.new(book)

            render(status: :ok, json: serializer.serializable_hash)
          end
        end
      end
    end
  end
end
