class CreateGoals < ActiveRecord::Migration[8.0]
  def change
    create_table :goals do |t|
      t.references :user, null: false, foreign_key: true
      t.float :target_weight
      t.date :target_date

      t.timestamps
    end
  end
end
