require 'rails_helper'

RSpec.describe User, type: :model do
  context "when creating a user" do
    before(:each) do
      @user = create(:user)
    end

    it "successfully creates a user" do
      expect(@user).to be_valid
    end

    it "is invalid without a first name" do
      user_without_first_name = build(:user, first_name: nil)
      expect(user_without_first_name).not_to be_valid
      expect(user_without_first_name.errors[:first_name]).to include("can't be blank")
    end

    it "is invalid without a last name" do
      user_without_last_name = build(:user, last_name: nil)
      expect(user_without_last_name).not_to be_valid
      expect(user_without_last_name.errors[:last_name]).to include("can't be blank")
    end

    it "is invalid without a username" do
      user_without_username = build(:user, username: nil)
      expect(user_without_username).not_to be_valid
      expect(user_without_username.errors[:username]).to include("can't be blank")
    end

    it "is invalid without a unique username" do
      user_with_unique_username = build(:user, username: "username")
      user_with_unique_username.save(validate: false)

      # Try to build a second user with the same username
      user_with_copied_username = build(:user, username: "username")

      expect(user_with_copied_username).not_to be_valid
      expect(user_with_copied_username.errors[:username]).to include("has already been taken")
    end
  end
end
