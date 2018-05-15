class CreateGists < ActiveRecord::Migration[5.1]
  def change
    create_table :gists do |t|
      t.string :description
      t.text :body

      t.timestamps
    end
  end
end
