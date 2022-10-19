class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :link
      t.float :rating
      t.integer :user_id
      t.integer :comment_id

      t.timestamps
    end
  end
end
