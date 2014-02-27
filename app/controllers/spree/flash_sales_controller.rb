class Spree::FlashSalesController < Spree::StoreController
  decorates_assigned :flash_sale

  respond_to :html

  def show
    @flash_sale = Spree::FlashSale.find(params[:id])
    spree_flash_sales_load_products
    @products = (@new_products + @products).uniq 
    respond_with(@flash_sale)
  end
end
