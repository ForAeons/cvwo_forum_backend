class UpdateSlugColumnInPosts < ActiveRecord::Migration[7.0]
  def change
    change_column_null :posts, :slug, false
    Post.where(slug: nil).update_all(slug: 'default-slug')
  end
end
