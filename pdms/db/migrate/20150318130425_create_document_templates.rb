class CreateDocumentTemplates < ActiveRecord::Migration
  def change
    create_table :document_templates do |t|
      t.string :name
      t.attachment :template

      t.timestamps
    end
  end
end
