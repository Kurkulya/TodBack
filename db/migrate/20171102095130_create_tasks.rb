class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.text :content
      t.integer :position
      t.boolean :is_done
      t.references :list, index: true, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
