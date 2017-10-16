class AddUserIdToWorks < ActiveRecord::Migration[5.0]
  def change
    remove_column :works, :created_by
    add_reference :works, :user, foreign_key: true
  end
end
