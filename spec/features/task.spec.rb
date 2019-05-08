# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
# 起動コマンド '$ bin/rspec spec/features/task.spec.rb'
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "タスク管理機能", type: :feature do
  background do
    # ユーザーを３名、タスクを各２件登録
    create(:user)
    create(:second_user)
    create(:third_user)
    create(:task)
    create(:second_task)
    create(:third_task)
    create(:fourth_task)
    create(:fifth_task)
    create(:sixth_task)

    # ユーザー「のび太」でログイン
    visit new_session_path
    fill_in 'session_email', with: 'helpDoraemon@f.com'
    fill_in 'session_password', with: '123456'
    click_on 'Log in'
  end

  # scenario（itのalias）の中に、確認したい各項目のテストの処理を書きます。
  scenario "タスク一覧のテスト" do
    # tasks_pathにvisitする（タスク一覧ページに遷移する）
    visit tasks_path

    # visitした（到着した）expect(page)に（タスク一覧ページに） 「のび太が作ったデフォルトのタイトル１と２」という文字列が
    # have_contentされているか？（含まれているか？）ということをexpectする（確認・期待する）テストを書いている
    expect(page).to have_content 'のび太が作ったデフォルトのタイトル１'
    expect(page).to have_content 'のび太が作ったデフォルトのタイトル２'
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
    click_link 'のび太が作ったデフォルトのタイトル１'

    # 詳細ページに内容が含まれているか確認
    expect(page).to have_content 'のび太が作ったデフォルトのコンテント１'

    # 別のタスクで確認
    visit tasks_path
    click_link 'のび太が作ったデフォルトのタイトル２'
    expect(page).to have_content 'のび太が作ったデフォルトのコンテント２'
  end

  scenario "タスクが作成日時順に並んでいるかのテスト" do
    visit tasks_path

    # ページ内のtrデータを取得、登録した２つのデータのうち、後データが上にきているか確認
    row = page.all('tr')
    expect(row[1]).to have_content 'のび太が作ったデフォルトのタイトル２'
  end

  scenario "タスクを終了期限順にソートする機能のテスト" do
    visit tasks_path
    # ソートボタンを押す
    click_link '終了期限で並び替え'

    # 終了期限でソート出来ているかを確認
    row = page.all('tr')
    expect(row[1]).to have_content '2025-02-02'
  end

  scenario "タスクを優先度順にソートする機能のテスト" do
    visit tasks_path
    # ソートボタンを押す
    click_link '優先度で並び替え'

    # 優先度でソート出来ているかを確認
    row = page.all('tr')
    expect(row[1]).to have_content '中'
  end

  scenario "タスクを名前で検索する機能のテスト" do
    visit tasks_path
    fill_in 'task_name', with: 'のび太が作ったデフォルトのタイトル１'
    select '', from: 'task_status'
    click_on '検索'
    expect(page).to have_content ''
  end

  scenario "タスクをステータスで検索する機能のテスト" do
    visit tasks_path
    select '未着手', from: 'task_status'
    click_on '検索'
    expect(page).to have_content 'のび太が作ったデフォルトのタイトル１'
  end

  scenario "ページネーション機能のテスト" do
    # テストデータを６件登録、１ページの最大表示件数を５件に設定
    # １件目の登録データが２ページ目に表示される事を確認する
    create(:seventh_task)
    create(:eighth_task)
    create(:ninth_task)
    create(:tenth_task)
    visit tasks_path
    click_link '次'
    expect(page).to have_content 'のび太が作ったデフォルトのタイトル１'
  end
end