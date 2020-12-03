class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.references :availability, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :confirmation

      t.timestamps
    end
  end
end
