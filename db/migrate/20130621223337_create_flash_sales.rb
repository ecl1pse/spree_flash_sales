class CreateFlashSales < ActiveRecord::Migration
  def change
    create_table :spree_flash_sales do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :active
      t.string :permalink
      t.belongs_to :saleable, polymorphic: true

      t.timestamps
    end
  end
end
