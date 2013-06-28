module Spree
  HomeController.class_eval do
    decorates_assigned :flash_sales # exposes flash_sales in view as helper method

    def index
      @flash_sales = Spree::FlashSale.live

      respond_with(@flash_sales)
    end
  end
end
