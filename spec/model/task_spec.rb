require 'rails_helper'

RSpec.describe Task, type: :model do


  it "titleが空ならバリデーションが通らない" do
    task = Task.new(name: '', user_id: 1)
    expect(task).not_to be_valid
  end

  it "titleに内容が記載されていればバリデーションが通る" do
    user = User.create(id: 1, name: 'のび太', email: 'a@a.com', password: '123456', password_confirmation: '123456')
    task = Task.new(name: 'なんかのタスク', user_id: 1)
    expect(task).to be_valid
  end

end