class CreateTodo < ActiveRecord::Migration[7.0]
  def change
    create_table :todos do |t|
      t.string :description, null: false
      t.boolean :completed, null: false
      t.references :todo_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
