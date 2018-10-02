class CreatePublications < ActiveRecord::Migration[5.2]
  def change
    create_table :publications do |t|
      t.references :publishable, polymorphic: true, index: true
      t.string :description
      t.timestamps
    end
  end
end
