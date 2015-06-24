class CreateNudges < ActiveRecord::Migration
  def change
    create_table :nudges do |t|

    	t.belongs_to :nudger
    	t.belongs_to :nudgee
    	t.belongs_to :event
    	t.timestamps null: false
    end
  end
end
