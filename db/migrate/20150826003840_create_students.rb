class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :username
      t.integer :school_id
      t.string :address

      t.timestamps null: false
    end

    add_index :students, :username, unique: true
  end
end
