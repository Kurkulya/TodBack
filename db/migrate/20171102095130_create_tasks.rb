class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :label
      t.integer :position
      t.references :list, type: :uuid, index: true, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
