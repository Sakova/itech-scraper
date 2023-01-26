class RemoveCommentIdFromArticles < ActiveRecord::Migration[6.1]
  def change
    remove_column :articles, :comment_id, if_exists: true
  end
end
