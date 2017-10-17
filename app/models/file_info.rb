class FileInfo < ApplicationRecord
  include Hashid::Rails

  has_secure_password
  has_one :file_content

  scope :find_by_hashid!, ->(hashid) {
    find(decode_id(hashid))
  }

  scope :public_file_infos, -> {
    where(private: false)
  }
end
