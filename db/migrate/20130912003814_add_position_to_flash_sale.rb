class AddPositionToFlashSale < ActiveRecord::Migration
  def change
    add_column :spree_flash_sales, :position, :integer
  end
end
