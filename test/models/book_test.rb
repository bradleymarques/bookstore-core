require "test_helper"

class BookTest < ActiveSupport::TestCase
  test "a book with all required fields is valid" do
    author = FactoryBot.create(:user)

    book = FactoryBot.build(
      :book,
      title: "Man's Search for Meaning",
      description: "Some description...",
      price_usd: 9.99,
      user: author
    )

    assert(book)
    assert(book.valid?)
    assert(book.save)
  end

  test "author and user are aliases for one another" do
    user = FactoryBot.create(:user)
    book_1 = FactoryBot.create(:book, user: user)
    book_2 = FactoryBot.create(:book, author: user)

    assert_equal(user, book_1.user)
    assert_equal(user, book_1.author)
    assert_equal(user, book_2.user)
    assert_equal(user, book_2.author)
  end

  test "a book without an author is invalid" do
    book = FactoryBot.build(:book, author: nil)

    refute(book.valid?)
  end

  test "a book without an title is invalid" do
    book = FactoryBot.build(:book, title: nil)

    refute(book.valid?)
  end

  test "a book without an description is invalid" do
    book = FactoryBot.build(:book, description: nil)

    refute(book.valid?)
  end
end
