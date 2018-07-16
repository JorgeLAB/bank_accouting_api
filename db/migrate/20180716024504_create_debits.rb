class CreateDebits < ActiveRecord::Migration[5.2]
  def change
    create_table :debits do |t|
      t.decimal :amount, precision: 8, scale: 2
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
