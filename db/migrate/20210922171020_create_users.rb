class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :token
      t.datetime :token_expires_at

      t.timestamps
    end
  end
end
