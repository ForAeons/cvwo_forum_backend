class FixSpellingErrorInColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :catergory, :category
  end
end
