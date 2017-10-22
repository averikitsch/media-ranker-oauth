require 'test_helper'

describe UsersController do
  describe "auth_callback" do
    it "logs in an existing user and redirects to the root route" do

      start_count = User.count
      user = users(:dan)
      login(user)

      must_redirect_to root_path

      session[:user_id].must_equal user.id
      User.count.must_equal start_count
    end


    it "creates an account for a new user and redirects to the root route" do
      start_count = User.count
      user = User.new(provider: "github", uid: 99999, username: "test_user", email: "test@user.com")

      login(user)

      must_redirect_to root_path

      User.count.must_equal start_count + 1

      # The new user's ID should be set in the session
      session[:user_id].must_equal User.last.id
    end

    it "redirects to the login route if given invalid user data" do
      start_count = User.count
      user = User.new(provider: "github", uid: 99999, username: "", email: "test@user.com")

      login(user)

      must_redirect_to root_path

      User.count.must_equal start_count

      # The new user's ID should be set in the session
      session[:user_id].must_be_nil
    end

    it "can log out" do
      user = User.new(provider: "github", uid: 99999, username: "test_user", email: "test@user.com")

      login(user)
      post logout_path
      session[:user_id].must_be_nil
      must_redirect_to root_path
    end
  end

end
