class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :code
      t.string :usuable_at
      t.integer :type, limit: 1
      t.integer :value
      t.integer :unit, limit: 1
      t.integer :status, limit: 1
      t.timestamp :expire_at
      t.belongs_to :user
      t.belongs_to :space

      t.timestamps
    end
  end
end
