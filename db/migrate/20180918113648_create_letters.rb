class CreateLetters < ActiveRecord::Migration[5.1]
  def change
    create_table :letters do |t|
      t.references :user, foreign_key: true
      t.string :url
      t.string :email
      t.string :letter_status
      t.text :comment

      t.timestamps
    end
  end
end
