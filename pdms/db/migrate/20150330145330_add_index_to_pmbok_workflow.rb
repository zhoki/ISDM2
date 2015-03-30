class AddIndexToPmbokWorkflow < ActiveRecord::Migration
  def change
    add_index :pmbok_workflows, [:pmbok_process_id, :document_template_id], name: 'unique_workflow', unique: true
  end
end
