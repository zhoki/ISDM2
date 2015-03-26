class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.date :assignedOn
      t.references :project, index: true
      t.references :document, index: true
      t.string :approver
      t.string :assignnee
      t.string :status

      t.timestamps
    end
  end
end
