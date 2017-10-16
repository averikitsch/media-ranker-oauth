class AddCreatedbyColumnToWork < ActiveRecord::Migration[5.0]
  def change
    add_column :works, :created_by, :integer
  end
end
