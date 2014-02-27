class AddProductSorting < ActiveRecord::Migration
  def change
    add_column :spree_flash_sales, :product_sorting, :string 
  end
end
