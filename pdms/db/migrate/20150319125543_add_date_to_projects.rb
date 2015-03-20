class AddDateToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :startDate, :date
    add_column :projects, :dueDate, :date
  end
end
