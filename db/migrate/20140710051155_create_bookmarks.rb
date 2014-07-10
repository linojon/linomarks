class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :link
      t.string :topic
      t.references :user, index: true

      t.timestamps
    end
  end
end
