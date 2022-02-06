module Api
  module V1
    class BooksController < ApplicationController
      before_action :require_jwt, except: [:index, :show]

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

      def create
        respond_to do |format|
          format.json do
            book = Book.new(create_params.merge({ user: current_user }))

            if book.save
              serializer = BookSerializer.new(book)
              render(status: :created, json: serializer.serializable_hash)
            else
              # TODO: Handle error case
            end
          end
        end
      end

      private

      def create_params
        params.require(:book).permit(:title, :description, :price_usd)
      end
    end
  end
end
