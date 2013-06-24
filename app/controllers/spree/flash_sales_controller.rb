class Spree::FlashSalesController < Spree::StoreController

  respond_to :html

  def show
    @flash_sale = Spree::FlashSale.find(params[:id])

    respond_with(@flash_sale)
  end
end
