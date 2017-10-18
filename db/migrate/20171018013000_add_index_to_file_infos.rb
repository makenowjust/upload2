class AddIndexToFileInfos < ActiveRecord::Migration[5.1]
  def change
    add_index :file_infos, [:created_at, :private, :expiration]
  end
end
