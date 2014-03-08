require_dependency 'spree/base_controller'
Spree::BaseController.class_eval do
  def spree_flash_sales_load_products
    @flash_sale                   = Spree::FlashSale.find(params[:id])

    if @flash_sale.saleable_type == "Spree::Taxon"

      if @flash_sale.product_sorting.present?
        @unsorted_products        = @flash_sale.saleable.active_products.find_all_by_id(@flash_sale.product_sorting)

        @flash_sale.saleable.descendants.each do |taxon|
          @unsorted_products += taxon.active_products.find_all_by_id(@flash_sale.product_sorting) # => Products That Already Shorted
        end

        @products                 = @flash_sale.product_sorting.collect {|id| @unsorted_products.detect {|x| x.id == id.to_i} }
        @products.reject!(&:blank?)
        @products                 = @flash_sale.saleable.active_products.find_all_by_id(@flash_sale.product_sorting) if @products.blank?
        @products.uniq!
        @new_products             = []
    
        @flash_sale.saleable.descendants.each do |taxon|
          @new_products += taxon.active_products.where("spree_products.id NOT IN (?)", @flash_sale.product_sorting) # => New Products That Have not been sorted
        end

        @new_products.uniq!
        @new_products = @new_products.sort_by{|v, k| v.created_at}.reverse
      else
        @new_products             = @flash_sale.saleable.active_products

        @flash_sale.saleable.descendants.each do |taxon|
          @new_products += taxon.active_products
        end

        @new_products.uniq!
        @new_products             = @new_products.sort_by{|v, k| v.created_at}.reverse
        @products                 = []
      end
    else
      @products = [@flash_sale.saleable]
    end

  end
end