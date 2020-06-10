class RenameZipcodeColumnInBusinessesToAddress < ActiveRecord::Migration[5.2]
  def change
    rename_column :businesses, :zipcode, :address
  end
end
