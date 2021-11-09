class CreateClaimPointRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :claim_point_requests do |t|
      t.string :title
      t.integer :status, limit: 1
      t.string :reference_link
      t.integer :claim_points
      t.belongs_to :user
      t.belongs_to :space

      t.timestamps
    end
  end
end
