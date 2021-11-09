class CreateSpacesUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :spaces_users do |t|
      t.string :username
      t.integer :user_role, limit: 1
      t.string :user_password_digest
      t.integer :user_reward_points
      t.integer :user_claimable_points
      t.belongs_to :user
      t.belongs_to :space

      t.timestamps
    end
  end
end
