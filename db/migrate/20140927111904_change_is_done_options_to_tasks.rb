class ChangeIsDoneOptionsToTasks < ActiveRecord::Migration
  def change
    change_column :tasks, :is_done, :boolean, null: false, default: false
  end
end
