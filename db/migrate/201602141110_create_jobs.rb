class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :position
      t.string :filename
      t.string :description
      t.string :hyperlink
      t.string :attachment
      t.string :job_type
      t.references :employer, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
