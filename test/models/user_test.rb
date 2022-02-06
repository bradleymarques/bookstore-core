require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "a user has to have a non-nil username" do
    user = FactoryBot.build(:user, username: nil)

    refute(user.valid?)
  end

  test "a user is valid and can be saved with a username" do
    username = "billybob@example.com"

    user = FactoryBot.build(:user, username: username)

    assert(user.valid?)
    assert(user.save)
  end

  test "a user has to have a unique username" do
    username = "billybob@example.com"

    user_1 = FactoryBot.build(:user, username: username)
    assert(user_1.valid?)
    assert(user_1.save)

    user_2 = FactoryBot.build(:user, username: username)
    refute(user_2.valid?)
    refute(user_2.save)
  end
end
