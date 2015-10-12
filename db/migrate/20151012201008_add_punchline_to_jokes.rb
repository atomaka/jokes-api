class AddPunchlineToJokes < ActiveRecord::Migration
  def change
    add_column :jokes, :punchline, :string
  end
end
