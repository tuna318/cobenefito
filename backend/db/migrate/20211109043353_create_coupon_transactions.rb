class CreateCouponTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :coupon_transactions do |t|
      t.integer :price
      t.integer :buyer_id
      t.integer :seller_id
      t.belongs_to :space
      t.belongs_to :coupon

      t.timestamps
    end
  end
end
