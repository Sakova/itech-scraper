class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :text
      t.float :rating
      t.integer :article_id

      t.timestamps
    end
  end
end
