class DestroyUpFromStars < ActiveRecord::Migration[5.1]
  def change
    remove_column :stars, :up
  end
end
