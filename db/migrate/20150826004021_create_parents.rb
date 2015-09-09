class CreateParents < ActiveRecord::Migration
  def change
    create_table :parents do |t|

      t.timestamps null: false
    end
  end
end
