require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe "validações" do
    it "é válido com user_id, post_id e valor" do
      rating = FactoryBot.build(:rating)
      expect(rating).to be_valid
    end

    it "é inválido user_id" do
      rating = FactoryBot.build(:rating, user_id: nil)
      expect(rating).not_to be_valid
    end

    it "é inválido post_id" do
      rating = FactoryBot.build(:rating, post_id: nil)
      expect(rating).not_to be_valid
    end

    it "é inválido value" do
      rating = FactoryBot.build(:rating, value: nil)
      expect(rating).not_to be_valid
    end
  end
end
