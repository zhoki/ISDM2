class CreateTaskStatuses < ActiveRecord::Migration
  def change
    create_table :task_statuses do |t|
      t.string :name, null: true
      t.timestamps
    end

    add_index :task_statuses, :name, unique: true
  end
end
