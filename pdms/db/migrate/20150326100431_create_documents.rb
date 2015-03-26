class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :project, index: true
      t.references :document_template, index: true

      t.timestamps
    end
  end
end
