class UpdateColumnInPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :slug, :string
  end
end
