class CreateFileContents < ActiveRecord::Migration[5.1]
  def change
    create_table :file_contents do |t|
      t.references :file_info, null: false
      t.binary :content, null: false, limit: 500.kilobyte

      t.timestamps
    end
  end
end
