class CreateFileInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :file_infos do |t|
      t.string :name, null: false
      t.string :password_digest, null: false
      t.integer :content_size, null: false
      t.boolean :private, null: false
      t.datetime :expiration, null: true

      t.timestamps
    end
  end
end
