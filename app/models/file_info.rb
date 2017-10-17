class FileInfo < ApplicationRecord
  include Hashid::Rails

  has_secure_password
  has_one :file_content, dependent: :destroy

  scope :public_file_infos, -> {
    where(
      "private = :private AND (expiration IS NULL OR expiration >= :expiration)",
      private: false,
      expiration: Time.current
    ).order(:created_at).reverse_order
  }

  def file=(file)
    self.name = file.original_filename

    io = file.to_io
    io.set_encoding(Encoding::ASCII_8BIT, Encoding::ASCII_8BIT)
    content = io.read

    self.content_size = content.size
    self.file_content = FileContent.new
    self.file_content.content = content
  end

  def outdated?
    return false unless expiration
    expiration < Time.current
  end
end
