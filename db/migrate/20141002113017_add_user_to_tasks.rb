class AddUserToTasks < ActiveRecord::Migration
  def change
    add_reference :tasks, :user, index: true, null: false, default: 0
  end
end
