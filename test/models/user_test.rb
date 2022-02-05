require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "a user has to have a non-nil username" do
    user = FactoryBot.build(:user, username: nil)
    refute(user.valid?)
  end
end
