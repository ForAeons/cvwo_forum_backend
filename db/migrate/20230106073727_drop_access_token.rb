class DropAccessToken < ActiveRecord::Migration[7.0]
  def change
    drop_table :access_tokens
  end
end
