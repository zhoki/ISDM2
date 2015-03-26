class AddDocumentTemplateIdToTasks < ActiveRecord::Migration
  def change
    add_reference :tasks, :document_template, index: true
  end
end
