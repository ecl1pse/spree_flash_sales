module Spree
  HomeController.class_eval do
    def index
      @flash_sales = Spree::FlashSale.live

      respond_with(@flash_sales)
    end
  end
end
