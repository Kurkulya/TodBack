class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.string :label
      t.references :user, type: :uuid, index: true, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
