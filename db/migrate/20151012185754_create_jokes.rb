class CreateJokes < ActiveRecord::Migration
  def change
    create_table :jokes do |t|
      t.string :joke

      t.timestamps null: false
    end
  end
end
