class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :transaction, null: false, foreign_key: true
      t.text :content
      t.integer :score

      t.timestamps
    end
  end
end
