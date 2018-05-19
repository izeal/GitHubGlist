class CreateStars < ActiveRecord::Migration[5.1]
  def change
    create_table :stars do |t|
      t.references :user, foreign_key: true
      t.references :gist, foreign_key: true
      t.boolean :up

      t.timestamps
    end
  end
end
