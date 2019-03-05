class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :title, null: false
      t.text :url
      t.text :content
      t.integer :author_id, null: false

    end
   
    add_index :posts, :author_id

    create_table :postsubs do |t|
      t.integer :sub_id, null: false
      t.integer :post_id, null: false
    end
    add_index :postsubs, :sub_id
    add_index :postsubs, :post_id
  end
end
