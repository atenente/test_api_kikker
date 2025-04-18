require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validações" do
    it "é válido com título, corpo, ip e usuário" do
      post = FactoryBot.build(:post)
      expect(post).to be_valid
    end

    it "é inválido sem título" do
      post = FactoryBot.build(:post, title: nil)
      expect(post).not_to be_valid
    end

    it "é inválido sem corpo" do
      post = FactoryBot.build(:post, body: nil)
      expect(post).not_to be_valid
    end

    it "é inválido sem ip" do
      post = FactoryBot.build(:post, ip: nil)
      expect(post).not_to be_valid
    end

    it "é inválido sem user" do
      post = FactoryBot.build(:post, user: nil)
      expect(post).not_to be_valid
    end
  end

end
