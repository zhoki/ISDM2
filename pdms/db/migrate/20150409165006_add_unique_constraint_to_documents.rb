class AddUniqueConstraintToDocuments < ActiveRecord::Migration
  def change
    add_index :documents, [:project_id, :document_template_id], unique: true
  end
end
