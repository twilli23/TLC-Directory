class CreateEnrollments < ActiveRecord::Migration[5.2]
  def change
    create_table :enrollments do |t|
      t.belongs_to :user, index: true
      t.belongs_to :university, index: true
      t.timestamps
    end
  end
end
