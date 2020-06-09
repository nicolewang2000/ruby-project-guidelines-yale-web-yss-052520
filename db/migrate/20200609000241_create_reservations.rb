class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.datetime :date
      t.integer :guest_number
      t.integer :user_id
      t.integer :business_id
    end
  end
end
