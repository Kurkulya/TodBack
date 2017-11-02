class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.text :content
      t.integer :position
      t.boolean :is_done

      t.timestamps
    end
  end
end
