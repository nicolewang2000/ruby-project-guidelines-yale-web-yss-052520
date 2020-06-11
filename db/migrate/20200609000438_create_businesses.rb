class CreateBusinesses < ActiveRecord::Migration[5.2]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :yelp_business_id
      t.string :address
      t.float :avg_rating
      t.integer :review_count
      t.string :price
    end
  end
end
