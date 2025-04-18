require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "é valido com login" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "é invalido sem login" do
      user = build(:user, login: nil)
      expect(user).not_to be_valid
      expect(user.errors[:login]).to include("can't be blank")
    end
  end

  describe "associations" do
    it "has many posts" do
      user = create(:user)
      3.times { create(:post, user: user) }
      expect(user.posts.count).to eq(3)
    end
  end
end
