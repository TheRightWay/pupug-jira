class AddPublickIdToTasks < ActiveRecord::Migration[6.1]
  def change
    change_table :task_lists do |t|
      t.uuid :public_id, default: 'gen_random_uuid()', null: false
    end
    add_index :task_lists, :public_id
  end
end
