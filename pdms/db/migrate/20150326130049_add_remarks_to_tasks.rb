class AddRemarksToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :remarks, :string
  end
end
