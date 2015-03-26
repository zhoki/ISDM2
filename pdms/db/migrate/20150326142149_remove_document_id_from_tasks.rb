class RemoveDocumentIdFromTasks < ActiveRecord::Migration
  def change
    remove_reference :tasks, :document, index: true
  end
end
