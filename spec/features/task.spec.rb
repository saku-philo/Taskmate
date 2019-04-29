# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
# 起動コマンド '$ bin/rspec spec/features/task.spec.rb'
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "タスク管理機能", type: :feature do
  background do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    #Task.create!(name: 'test_task_01', description: 'testtesttest')
    #Task.create!(name: 'test_task_02', description: 'samplesample')
  end
  # scenario（itのalias）の中に、確認したい各項目のテストの処理を書きます。
  scenario "タスク一覧のテスト" do
    # tasks_pathにvisitする（タスク一覧ページに遷移する）
    visit tasks_path

    # visitした（到着した）expect(page)に（タスク一覧ページに）「testtesttest」「samplesample」という文字列が
    # have_contentされているか？（含まれているか？）ということをexpectする（確認・期待する）テストを書いている
    expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
    expect(page).to have_content 'Factoryで作ったデフォルトのタイトル２'
    expect(page).to have_content 'Factoryで作ったデフォルトのタイトル３'
  end

  scenario "タスク作成のテスト" do
    # new_task_pathにvisitする（タスク登録ページに遷移する）
    # 1.ここにnew_task_pathにvisitする処理を書く
    visit new_task_path

    # 「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄に
    # タスクのタイトルと内容をそれぞれfill_in（入力）する
    # 2.ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
    fill_in 'task_name', with: 'shopping'

    # 3.ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
    fill_in 'task_description', with: 'buy meet'

    # 終了期限登録
    fill_in 'task_due_date', with: '2019-02-28'

    #優先順位登録
    select '高', from: '優先度'
    # 「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）
    # 4.「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
    click_on '登録する'

    # clickで登録されたはずの情報が、タスク一覧ページに表示されているかを確認する
    # 5.タスク詳細ページに、テストコードで作成したはずのデータ（記述）がhave_contentされているか（含まれているか）を確認（期待）するコードを書く
    expect(page).to have_content 'shopping', '2019-02-28'
    expect(page).to have_content '高'
  end

  scenario "タスク詳細のテスト" do
    # 任意のタスク詳細画面に遷移したら、該当タスクの内容が表示されたページに遷移することを確認する
    # 一覧画面に移動
    visit tasks_path

    # タスク名（リンクボタン）をクリック
    click_link 'Factoryで作ったデフォルトのタイトル１'

    # 詳細ページに内容が含まれているか確認
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント１'

    # 別のタスクで確認
    visit tasks_path
    click_link 'Factoryで作ったデフォルトのタイトル２'
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント２'
  end

  scenario "タスクが作成日時順に並んでいるかのテスト" do
    visit tasks_path

    # ページ内のtrデータを取得、登録した３つのデータのうち、後データが上にきているか確認
    row = page.all('tr')
    expect(row[1]).to have_content 'Factoryで作ったデフォルトのタイトル３'
  end

  scenario "タスクを終了期限順にソートする機能のテスト" do
    visit tasks_path
    # ソートボタンを押す
    click_link '終了期限で並び替え'

    # 終了期限でソート出来ているかを確認
    row = page.all('tr')
    expect(row[1]).to have_content '2019-04-30'
  end

  scenario "タスクを優先度順にソートする機能のテスト" do
    visit tasks_path
    # ソートボタンを押す
    click_link '優先度で並び替え'

    # 優先度でソート出来ているかを確認
    row = page.all('tr')
    expect(row[1]).to have_content '高'
  end

  scenario "タスクを名前で検索する機能のテスト" do
    visit tasks_path
    fill_in 'task_name', with: '１'
    select '', from: 'task_status'
    click_on '検索'
    expect(page).to have_content 'Factoryで作ったデフォルトのタイトル１'
  end

  scenario "タスクをステータスで検索する機能のテスト" do
    visit tasks_path
    select '着手中', from: 'task_status'
    click_on '検索'
    expect(page).to have_content 'Factoryで作ったデフォルトのタイトル２'
  end

end