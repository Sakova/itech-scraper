class RemoveCommentIdFromArticles < ActiveRecord::Migration[6.1]
  def change
    remove_column :articles, :comment_id
  end
end
