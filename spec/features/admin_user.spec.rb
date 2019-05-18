require 'rails_helper'

RSpec.feature "ユーザー管理機能のテスト", type: :feature do
  background do
    # ユーザーを３名作成
    create(:user)
    create(:second_user)
    create(:third_user)

    # ラベルを３件作成
    create(:label)
    create(:second_label)
    create(:third_label)

    # タスクを各ユーザー２件作成
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

  scenario "ナビゲーションバーの「管理画面」を押すと登録ユーザー一覧画面に移動するテスト" do
    # 管理画面に移動
    click_link '管理者画面'

    # ユーザー一覧が表示されているか確認
    expect(page).to have_content '登録ユーザー一覧'
    expect(page).to have_content 'のび太'
    expect(page).to have_content 'スネ夫'
    expect(page).to have_content 'ジャイアン'
  end

  scenario "管理者権限でユーザー登録をするテスト" do
    # ユーザー登録画面に移動
    visit admin_users_path
    click_link 'ユーザー登録'
    # 名前、メアド、パスワードを入力、アカウント作成ボタンを押す
    fill_in 'user_name', with: 'しずか'
    fill_in 'user_email', with: 'love_bath@f.com'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'
    click_on 'アカウント作成'

    # 一覧画面に移動、ユーザー登録が出来ているか確認
    expect(page).to have_content 'しずか'
  end

  scenario "ユーザー詳細画面の確認テスト" do
    # 管理画面に移動
    click_link '管理者画面'

    # ３番目の登録ユーザー画面へ
    page.all(".user_task")[2].click_link('詳細')
    expect(page).to have_content 'ジャイアン'
    expect(page).to have_content 'ジャイアンが作ったデフォルトのタイトル５'
    expect(page).to have_content 'ジャイアンが作ったデフォルトのタイトル６'
  end

  scenario "ユーザー情報変更のテスト" do
    # 管理画面に移動
    click_link '管理者画面'

    # ３番目の登録ユーザー画面へ
    page.all(".user_task")[2].click_link('詳細')

    # ユーザー情報を編集
    click_on 'ユーザー編集'
    fill_in 'user_name', with: 'ジャイ子'
    fill_in 'user_email', with: 'nobita-love@f.com'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'
    click_on 'ユーザー情報更新'

    # 一覧画面で変更が表示されているか確認
    expect(page).not_to have_content 'ジャイアン'
    expect(page).to have_content 'ジャイ子'
  end

  scenario "ユーザー情報削除のテスト" do
    # 管理画面に移動
    click_link '管理者画面'

    # ２番目の登録ユーザー画面へ
    page.all(".user_task")[1].click_link('詳細')

    # ユーザー情報を削除
    click_on 'ユーザー削除'

    # 一覧画面にて削除を確認
    row = page.all('tr')
    expect(row).not_to have_content 'スネ夫'
  end
end