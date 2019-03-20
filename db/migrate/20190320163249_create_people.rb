class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :name, null: false, default: false
      t.text :bio
      t.string :remark
      t.boolean :del, null: false, default: false

      t.timestamps
    end
  end
end
