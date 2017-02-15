class CreateOutlets < ActiveRecord::Migration[5.0]
  def change
    create_table :outlets do |t|
      t.string :type
      t.string :title
      t.text :body
      t.integer :urgency
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
