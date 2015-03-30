class CreatePmbokProcesses < ActiveRecord::Migration
  def change
    create_table :pmbok_processes do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
