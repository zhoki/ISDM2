class AddUploadbyToDocumentTemplates < ActiveRecord::Migration
  def change
    add_column :document_templates, :uploadedBy, :string
  end
end
