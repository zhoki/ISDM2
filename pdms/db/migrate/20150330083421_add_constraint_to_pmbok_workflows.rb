class AddConstraintToPmbokWorkflows < ActiveRecord::Migration
  def up
    execute "ALTER TABLE pmbok_workflows ADD CONSTRAINT check_doctype_constraint CHECK (doctype in ('I', 'O', 'i', 'o'))"
  end

  def down
    execute "ALTER TABLE pmbok_workflows DROP CONSTRAINT check_doctype_constraint"
  end
end
