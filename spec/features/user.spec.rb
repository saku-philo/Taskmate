require 'rails_helper'

RSpec.feature "ユーザー毎のタスク管理機能", type: :feature do
  background do
    create(:user)
    create(:second_user)
    create(:third_user)
    create(:label)
    create(:second_label)
    create(:third_label)
    create(:task)
    create(:second_task)
    create(:third_task)
    create(:fourth_task)
    create(:fifth_task)
    create(:sixth_task)
  end

  # scenario（itのalias）の中に、確認したい各項目のテストの処理を書きます。
  scenario "ユーザー新規登録、登録後、自動でログインしてマイページに移動するテスト" do
    # ユーザー登録画面に移動
    visit new_user_path

    # 名前、メアド、パスワードを入力、アカウント作成ボタンを押す
    fill_in 'user_name', with: 'しずか'
    fill_in 'user_email', with: 'love_bath@f.com'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'
    click_on 'アカウント作成'

    # マイページに移動、ログイン出来ているか確認
    expect(page).to have_content 'マイページ'
    expect(page).to have_content 'しずか'
    expect(page).to have_content "#{'love_bath@f.com'.downcase}"
    expect(page).to have_content 'ログアウト'
  end

  scenario "ログイン後、マイページに移動する機能のテスト" do
    # ログイン画面に移動
    visit new_session_path

    # フォームにメアドとパスワードを入力、ログインボタンを押下
    fill_in 'session_email', with: 'helpDoraemon@f.com'
    fill_in 'session_password', with: '123456'
    click_on 'Log in'

    # マイページに移動、ユーザー名とアドレスが表示されているか確認
    expect(page).to have_content 'マイページ'
    expect(page).to have_content 'のび太'
    expect(page).to have_content "#{'helpDoraemon@f.com'.downcase}"
  end

  scenario "ログアウト機能のテスト" do
    # ログイン画面に移動
    visit new_session_path

    # フォームにメアドとパスワードを入力、ログインボタンを押下
    fill_in 'session_email', with: 'helpDoraemon@f.com'
    fill_in 'session_password', with: '123456'
    click_on 'Log in'

    # ログアウトボタンを押す
    click_link 'ログアウト'
    # マイページに移動、ユーザー名とアドレスが表示されているか確認
    expect(page).to have_content 'ログアウトしました。'
    expect(page).to have_content 'ログイン'
  end

  scenario "ログインせず、タスクページに飛ぼうとすると、ログインページに遷移する機能のテスト" do
    # タスク一覧画面へ移動
    visit tasks_path

    expect(page).to have_content 'ログイン'
    expect(page).to have_content 'ユーザー登録'
  end

  scenario "自分が作成したタスクのみ表示される機能のテスト" do
    # ログイン画面に移動
    visit new_session_path

    # フォームにメアドとパスワードを入力、ログインボタンを押下
    fill_in 'session_email', with: 'helpDoraemon@f.com'
    fill_in 'session_password', with: '123456'
    click_on 'Log in'

    # タスク一覧画面に移動
    click_link 'タスク一覧'

    expect(page).to have_content 'のび太が作ったデフォルトのタイトル１'
    expect(page).to have_content 'のび太が作ったデフォルトのタイトル２'
  end

  scenario "ログインしている時は、ユーザー登録画面に行けないテスト" do
    # ログイン画面に移動
    visit new_session_path

    # フォームにメアドとパスワードを入力、ログインボタンを押下
    fill_in 'session_email', with: 'helpDoraemon@f.com'
    fill_in 'session_password', with: '123456'
    click_on 'Log in'

    # ユーザー登録画面に移動
    visit new_user_path

    # ログイン中はマイページに遷移、ユーザー登録は出来ないアラートがでる
    expect(page).to have_content 'マイページ'
    expect(page).to have_content 'ログイン中のユーザー登録は出来ません。'
  end

  scenario "自分以外のユーザーのマイページに行けないテスト" do
    # ログイン画面に移動
    visit new_session_path

    # フォームにメアドとパスワードを入力、ログインボタンを押下
    fill_in 'session_email', with: 'helpDoraemon@f.com'
    fill_in 'session_password', with: '123456'
    click_on 'Log in'

    # 他のユーザーのページに飛ぼうとすると、マイページに戻る
    visit user_path(id: 3)
    expect(page).to have_content 'のび太'
    expect(page).to have_content "#{'helpDoraemon@f.com'.downcase}"
    expect(page).to have_content '覗き見はだめよ❤️'
  end
end