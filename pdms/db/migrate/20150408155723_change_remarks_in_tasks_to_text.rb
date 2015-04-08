class ChangeRemarksInTasksToText < ActiveRecord::Migration
  def change
    change_column :tasks, :remarks, :text
  end
end
