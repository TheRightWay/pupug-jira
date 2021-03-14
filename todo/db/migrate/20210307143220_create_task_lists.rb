class CreateTaskLists < ActiveRecord::Migration[6.1]
  def change
    create_table :task_lists do |t|
      t.string :title
      t.text :description
      t.datetime :completed_at
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :task_lists, :completed_at
    add_index :task_lists, :deleted_at
  end
end
