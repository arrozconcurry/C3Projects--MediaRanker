class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name, null: false
      t.string :director
      t.string :description
      t.integer :rank

      t.timestamps null: false
    end
  end
end
