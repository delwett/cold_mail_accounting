class AddIndexEmailToLetter < ActiveRecord::Migration[5.1]
  def change
    add_index :letters, :email
  end
end
