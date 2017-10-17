class FileInfo < ApplicationRecord
  include Hashid::Rails

  has_secure_password
  has_one :file_content

  scope :find_by_hashid!, ->(hashid) {
    find(decode_id(hashid))
  }

  scope :public_file_infos, -> {
    where(
      "private = :private AND (expiration IS NULL OR expiration >= :expiration)",
      private: false,
      expiration: Time.current
    ).order(:created_at).reverse_order
  }

  def outdated?
    return true unless expiration
    expiration < Time.current
  end
end
