require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_url
    assert_response :success
    assert_select "form[action=?][method=?]", users_path, "post"
    assert_select "input[name=?]", "user[username]"
    assert_select "input[name=?]", "user[email]"
    assert_select "input[name=?]", "user[password]"
  end

  test "new form carries a csrf token" do
    with_forgery_protection do
      get new_user_url

      assert_select "meta[name=?]", "csrf-token"
      assert_select "input[name=?]", "authenticity_token"
    end
  end

  test "create without a csrf token is rejected" do
    with_forgery_protection do
      assert_no_difference "User.count" do
        post users_path, params: { user: { username: "foobar", email: "foo@bar.com", password: "secret" } }
      end

      assert_response :unprocessable_entity
    end
  end

  test "should create user" do
    assert_difference "User.count", 1 do
      post users_path, params: { user: { username: "foobar", email: "foo@bar.com", password: "secret" } }
    end

    assert_redirected_to new_user_path
    assert_equal "foobar", User.order(:id).last.username
  end

  test "should not create user with missing attributes" do
    assert_no_difference "User.count" do
      post users_path, params: { user: { username: "", email: "", password: "" } }
    end

    assert_response :unprocessable_entity
    assert_select "#error_explanation li", 3
  end

  test "should not create user without permitted params" do
    assert_no_difference "User.count" do
      post users_path, params: { user: { username: "foobar", admin: true } }
    end
  end

  test "should get edit" do
    user = User.create!(username: "foobar", email: "foo@bar.com", password: "secret")
    get edit_user_url(user)

    assert_response :success
    assert_select "input[name=?][value=?]", "_method", "patch"
    assert_select "input[name=?][value=?]", "user[username]", "foobar"
  end

  test "should update user" do
    user = User.create!(username: "foobar", email: "foo@bar.com", password: "secret")

    patch user_path(user), params: { user: { username: "foobar2" } }

    assert_redirected_to edit_user_path(user)
    assert_equal "foobar2", user.reload.username
  end

  test "should not update user with missing attributes" do
    user = User.create!(username: "foobar", email: "foo@bar.com", password: "secret")

    patch user_path(user), params: { user: { username: "" } }

    assert_response :unprocessable_entity
    assert_select "#error_explanation li", /Username/
  end
end
