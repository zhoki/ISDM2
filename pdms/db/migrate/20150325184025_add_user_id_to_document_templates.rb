class AddUserIdToDocumentTemplates < ActiveRecord::Migration
  def change
    add_column :document_templates, :user_id, :integer
  end
end
