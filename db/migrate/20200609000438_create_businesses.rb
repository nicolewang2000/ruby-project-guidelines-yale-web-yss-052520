class CreateBusinesses < ActiveRecord::Migration[5.2]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :zipcode
      t.float :avg_rating
      t.integer :review_count
    end
  end
end
