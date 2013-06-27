class Spree::Admin::FlashSalesController < Spree::Admin::ResourceController
  def index
    respond_with(@collection) do |format|
      format.html
    end
  end

  def saleables
    search = params[:saleable_type].constantize.search(:name_cont => params[:name])
    render :json => search.result.map(&:name)
  end

  protected
    def location_after_save
      edit_object_url(@object)
    end

    def collection
      return @collection if @collection.present?
      if request.xhr? && params[:q].present?
        @collection = Spree::FlashSale.search params[:q]
      else
        @search = Spree::FlashSale.ransack(params[:q])
        @collection = @search.result.page(params[:page]).per(Spree::Config[:admin_products_per_page])
      end
    end
end
