class CreateWeightLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :weight_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.float :weight
      t.float :body_fat
      t.text :memo

      t.timestamps
    end
  end
end
