require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "is valid with all attributes present" do
    user = User.new(username: "foobar", email: "foo@bar.com", password: "secret")

    assert user.valid?
  end

  test "requires username" do
    user = User.new(email: "foo@bar.com", password: "secret")

    assert_not user.valid?
    assert_includes user.errors.full_messages, "Username can't be blank"
  end

  test "requires email" do
    user = User.new(username: "foobar", password: "secret")

    assert_not user.valid?
    assert_includes user.errors.full_messages, "Email can't be blank"
  end

  test "requires password" do
    user = User.new(username: "foobar", email: "foo@bar.com")

    assert_not user.valid?
    assert_includes user.errors.full_messages, "Password can't be blank"
  end
end
