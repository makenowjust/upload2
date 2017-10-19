# frozen_string_literal: true

require 'test_helper'

class FilesControllerTest < ActionDispatch::IntegrationTest
  test 'index' do
    get root_url
    assert_response :ok
  end

  test 'show success' do
    get file_info_url(file_infos(:hello))
    assert_response :ok
  end

  test 'show failure (not found)' do
    assert_raise ActiveRecord::RecordNotFound do
      get file_info_url('404')
    end
  end

  test 'show failure (outdated)' do
    assert_raise ActiveRecord::RecordNotFound, 'outdated' do
      get file_info_url(file_infos(:expiration_old))
    end
  end

  test 'create success' do
    assert_difference -> { FileInfo.count }, 1 do
      post file_infos_url, params: { file_info: file_info_params_success }
      assert_redirected_to file_info_path(FileInfo.last)
      assert_equal 'Uploading OK', flash[:notice]
    end
  end

  test 'create failure' do
    assert_no_difference -> { FileInfo.count } do
      post file_infos_url, params: { file_info: file_info_params_failure }
      assert_response :bad_request
    end
  end

  test 'destroy success' do
    assert_difference -> { FileInfo.count }, -1 do
      delete file_info_url(file_infos(:hello)), params: { password: 'hello' }
      assert_redirected_to root_url
      assert_equal 'Deleting OK', flash[:notice]
    end
  end

  test 'destroy failure' do
    assert_no_difference -> { FileInfo.count } do
      delete file_info_url(file_infos(:hello)), params: { password: 'hell' }
      assert_redirected_to file_infos(:hello)
      assert_equal 'Deleting Failed (Invalid Password)', flash[:alert]
    end
  end

  private def file_info_params_success
    {
      file: fixture_file_upload('files/hello.txt', 'text/plain'),
      password: 'hello',
      password_confirmation: 'hello',
      expiration: nil,
      private: false
    }
  end

  private def file_info_params_failure
    {
      file: fixture_file_upload('files/hello.txt', 'text/plain'),
      password: 'hello',
      password_confirmation: 'hell',
      expiration: nil,
      private: false
    }
  end
end
