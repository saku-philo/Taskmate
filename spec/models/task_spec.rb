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

  it '複数label作成されるかのテスト(Bugfix用)' do
    params = {"name"=>"4", "description"=>"d", "due_date"=>"2019-04-25", "status"=>"未着手", "priority"=>"", "label_ids"=>["1"]}
    create(:label)
    user = create(:user)
    user.tasks.build(params)
    expect(TaskLabel.count).to eq 0
  end

  describe "scopes" do
    describe "search_label" do
      let!(:user) { create(:user) }
      let!(:label_1) { create(:label) }
      let!(:label_2) { create(:second_label) }
      let!(:label_3) { create(:third_label) }
      let!(:task_1) { create(:task) }
      let!(:task_2) { create(:second_task) }
      let!(:tasks) { user.tasks }
      params = { "label_id"=>"1", "search"=>"true" }
      subject { tasks.search_label(params).first.labels.first.id }
      it { is_expected.to eq 1 }
      #end
    end
  end
end


