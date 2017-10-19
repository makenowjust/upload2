require "application_system_test_case"

class FileUploadTest < ApplicationSystemTestCase
  test "upload file" do
    file_upload_test_txt_path = File.join(fixture_path, "files", "file_upload_test.txt")
    file_upload_test_txt_content = File.read(file_upload_test_txt_path)

    # まずトップページへ行く
    visit root_url

    # ファイルをアップロード
    attach_file "file_info_file", file_upload_test_txt_path, visible: false
    fill_in "file_info_password", with: "hello"
    fill_in "file_info_password_confirmation", with: "hell"
    click_button "Upload"

    # パスワードが間違っているので、もう一度入力する
    assert_equal file_infos_path, current_path
    attach_file "file_info_file", file_upload_test_txt_path, visible: false
    fill_in "file_info_password", with: "hello"
    fill_in "file_info_password_confirmation", with: "hello"
    click_button "Upload"

    # 個別ページに遷移するので、内容を確認
    assert_equal file_info_path(FileInfo.last), current_path
    assert_text "Uploading OK"
    assert_text "file_upload_test.txt"
    assert_text "#{file_upload_test_txt_content.size} Bytes"

    # ファイルのダウンロードをする
    click_link "Download"
    assert_equal download_path(FileInfo.last), current_path
    assert_text file_upload_test_txt_content
    go_back

    # 一旦トップページに戻って、アップロードしたファイルが一覧に追加されていることを確認
    click_link "The File Uploader"
    assert_equal root_path, current_path
    click_link "file_upload_test.txt"

    # 個別ページで削除を試みる
    assert_equal file_info_path(FileInfo.last), current_path
    fill_in "password", with: "hell"
    click_button "Delete"

    # パスワードが間違っているので失敗する
    assert_equal file_info_path(FileInfo.last), current_path
    assert_text "Deleting Failed (Invalid Password)"

    # もう一度入力して、今度は削除に成功する
    fill_in "password", with: "hello"
    click_button "Delete"
    assert_text "Deleting OK"
    assert_no_text "file_upload_test.txt"
  end
end
