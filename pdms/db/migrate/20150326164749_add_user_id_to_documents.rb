class AddUserIdToDocuments < ActiveRecord::Migration
  def change
    add_reference :documents, :user, index: true
  end
end
