FactoryBot.define do

  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    name { 'Factoryで作ったデフォルトのタイトル１' }
    description { 'Factoryで作ったデフォルトのコンテント１' }
    due_date { '2019-04-30' }
    status { '未着手' }
    priority { '低' }
  end

  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    name { 'Factoryで作ったデフォルトのタイトル２' }
    description { 'Factoryで作ったデフォルトのコンテント２' }
    due_date { '2020-12-31' }
    status { '着手中' }
    priority { '中' }
  end

  factory :third_task, class: Task do
    name { 'Factoryで作ったデフォルトのタイトル３' }
    description { 'Factoryで作ったデフォルトのコンテント３' }
    due_date { '2020-05-01' }
    status { '未着手' }
    priority { '高' }
  end
end