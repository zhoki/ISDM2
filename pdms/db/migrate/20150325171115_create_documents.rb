class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.integer :user_id
      t.attachment :file
      t.references :document_template, index: true

      t.timestamps
    end
  end
end
