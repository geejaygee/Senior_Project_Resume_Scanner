class CreateResumeDocuments < ActiveRecord::Migration
  def change
    create_table :resume_documents do |t|
      t.string :filename
      t.string :datafile
      t.string :attachment
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
