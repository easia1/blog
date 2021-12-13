class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :body
      t.date :task_date

      t.timestamps
    end
  end
end
