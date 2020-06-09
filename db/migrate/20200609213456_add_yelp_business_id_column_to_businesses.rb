class AddYelpBusinessIdColumnToBusinesses < ActiveRecord::Migration[5.2]
  def change
    add_column :businesses, :yelp_business_id, :string
  end
end
