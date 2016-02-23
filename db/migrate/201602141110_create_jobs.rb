class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :position
      t.string :filename
      t.string :attachment
      t.references :employer, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end