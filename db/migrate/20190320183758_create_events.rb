class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :is_public
      t.integer :capacity
      t.string :remark
      t.boolean :del, null: false, default: false

      t.timestamps
    end
  end
end
