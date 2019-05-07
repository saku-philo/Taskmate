require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  describe 'バリデーション' do
    it "nameが空ならバリデーションが通らない" do
      @user.name = ''
      expect(@user).not_to be_valid
    end

    it "nameが入っていればバリデーションが通る" do
      @user.name = 'ああ'
      expect(@user).to be_valid
    end

    it "emailが空ならバリデーションが通らない" do
      @user.email = ''
      expect(@user).not_to be_valid
    end

    it "emailが決まった型でない場合、バリデーションが通らない" do
      @user.email = "qwerty.com"
      expect(@user).not_to be_valid
    end

    it "passwordが空ならバリデーションが通らない" do
      @user.password_digest = ""
      expect(@user).not_to be_valid
    end

    it "passwordが5文字以下ならバリデーションが通らない" do
      @user.password = "12345"
      expect(@user).not_to be_valid
    end

    it "name,email,passwordに条件を満たした内容が記載されていればバリデーションが通る" do
      expect(@user).to be_valid
    end
  end
end
