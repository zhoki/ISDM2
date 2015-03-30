class CreatePmbokWorkflows < ActiveRecord::Migration
  def up
    create_table :pmbok_workflows do |t|
      t.references :pmbok_process, index: true
      t.references :document_template, index: true
      t.string :doctype, limit: 1,  default: nil
      
      t.timestamps
    end
  end

  def down
    drop_table :pmbok_workflows
  end
end
