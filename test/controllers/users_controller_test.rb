require 'test_helper'

describe UsersController do

  describe "index" do
    it "succeeds with many users" do
      user = users(:dan)
      login(user)
      # Assumption: there are many users in the DB
      User.count.must_be :>, 0

      get users_path
      must_respond_with :success
    end

    it "succeeds with no users" do
      user = users(:dan)
      login(user)
      # Start with a clean slate
      Vote.destroy_all # for fk constraint
      User.destroy_all
      login(user)
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "succeeds for an extant user" do
      user = users(:dan)
      login(user)
      get user_path(User.first)
      must_respond_with :success
    end

    it "renders 404 not_found for a bogus user" do
      user = users(:dan)
      login(user)
      # User.last gives the user with the highest ID
      bogus_user_id = User.last.id + 1
      get user_path(bogus_user_id)
      must_respond_with :not_found
    end
  end

  describe "must be logged in" do
    it "index" do
      get users_path
      must_redirect_to root_path
    end
    it "show" do
      get user_path(User.first)
      must_redirect_to root_path
    end
  end
end
