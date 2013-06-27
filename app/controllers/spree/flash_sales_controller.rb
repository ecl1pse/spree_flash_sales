class Spree::FlashSalesController < Spree::StoreController

  respond_to :html

  def show
    @flash_sale = Spree::FlashSale.find(params[:id])
    products = @flash_sale.saleable.active_products
    @flash_sale.saleable.descendants.each do |taxon|
      products += taxon.active_products
      products = products.uniq
    end
    @products = products

    respond_with(@flash_sale)
  end
end
