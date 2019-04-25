require 'rails_helper'

RSpec.describe Task, type: :model do

  it "titleが空ならバリデーションが通らない" do
    task = Task.new(name: '')
    expect(task).not_to be_valid
  end

  it "titleに内容が記載されていればバリデーションが通る" do
    task = Task.new(name: 'なんかのタスク')
    expect(task).to be_valid
  end

end