class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :wvu_username, limit: 30
      t.string :last_name
      t.string :first_name
      t.string :middle_name
      t.integer :role, default: :user
      t.integer :status, default: :disabled
      t.boolean :visible, default: false
      t.timestamps
    end
  end
end
