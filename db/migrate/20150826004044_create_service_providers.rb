class CreateServiceProviders < ActiveRecord::Migration
  def change
    create_table :service_providers do |t|
      t.integer :organization_id

      t.timestamps null: false
    end
  end
end
