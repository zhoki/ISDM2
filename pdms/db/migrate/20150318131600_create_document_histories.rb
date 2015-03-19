class CreateDocumentHistories < ActiveRecord::Migration
  def change
    create_table :document_histories do |t|
      t.string :uploadedBy
      t.integer :versionNumber
      t.string :checksum

      t.timestamps
    end
  end
end
