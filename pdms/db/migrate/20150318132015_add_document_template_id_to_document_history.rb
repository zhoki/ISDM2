class AddDocumentTemplateIdToDocumentHistory < ActiveRecord::Migration
  def change
    add_column :document_histories, :document_template_id, :integer
  end
end
