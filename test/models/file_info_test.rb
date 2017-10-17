require 'test_helper'

class FileInfoTest < ActiveSupport::TestCase
  test "find FileInfo by hashid" do
    id = file_infos(:hello).id
    hashid = FileInfo.encode_id(id)
    hello = FileInfo.find_by_hashid!(hashid)
    assert_equal file_infos(:hello), hello
  end

  test "not find FileInfo by id" do
    assert_raise ActiveRecord::RecordNotFound do
      id = file_infos(:hello).id
      FileInfo.find_by_hashid!(id)
    end
  end

  test "authenticate by password" do
    hello = file_infos(:hello)
    assert hello.authenticate("hello")
  end

  test "get associated FileContent" do
    hello = file_infos(:hello)
    assert file_contents(:hello_content), hello.file_content
  end
end
