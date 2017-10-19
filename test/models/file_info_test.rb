# frozen_string_literal: true

require 'test_helper'

class FileInfoTest < ActiveSupport::TestCase
  test 'find FileInfo by hashid' do
    id = file_infos(:hello).id
    hashid = FileInfo.encode_id(id)
    hello = FileInfo.find_by_hashid!(hashid)
    assert_equal file_infos(:hello), hello
  end

  test 'not find FileInfo by id' do
    assert_raise ActiveRecord::RecordNotFound do
      id = file_infos(:hello).id
      FileInfo.find_by_hashid!(id)
    end
  end

  test 'authenticate by password' do
    hello = file_infos(:hello)
    assert hello.authenticate('hello')
  end

  test 'get associated FileContent' do
    hello = file_infos(:hello)
    assert_equal file_contents(:hello_content), hello.file_content
  end

  test 'get public FileInfo list except outdated' do
    file_infos = FileInfo.public_file_infos
    assert_equal [file_infos(:expiration_new), file_infos(:hello)], file_infos
  end

  test 'check outdated' do
    old = file_infos(:expiration_old)
    assert old.outdated?
    new = file_infos(:expiration_new)
    assert !new.outdated?
  end

  test 'fill name, content_size and file_content via file' do
    file = fixture_file_upload('files/hello.txt', 'text/plain')
    content = "Hello, World!\n"

    file_info = FileInfo.new
    file_info.file = file

    assert_equal 'hello.txt', file_info.name
    assert_equal content.size, file_info.content_size
    assert_equal content, file_info.file_content.content
  end

  test 'validate file' do
    file_info = FileInfo.new
    file_info.name = ''
    file_info.validate
    assert_equal ["can't be empty"], file_info.errors[:file]

    file_info = FileInfo.new
    file_info.name = 'hello'
    file_info.content_size = nil
    file_info.validate
    assert_equal ["can't be empty"], file_info.errors[:file]

    file_info = FileInfo.new
    file_info.name = 'hello'
    file_info.content_size = 500.kilobytes
    file_info.validate
    assert_equal ['is too big'], file_info.errors[:file]
  end
end
