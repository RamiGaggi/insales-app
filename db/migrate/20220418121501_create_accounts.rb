class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.integer :insales_id, null: false
      t.string :insales_subdomain, null: false
      t.string :insales_application_password, null: false

      t.index :insales_id, unique: true
      t.index :insales_subdomain, unique: true
      t.timestamps
    end
  end
end
