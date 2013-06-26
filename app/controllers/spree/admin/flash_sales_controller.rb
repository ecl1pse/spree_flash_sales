class Spree::Admin::FlashSalesController < Spree::Admin::ResourceController
  def show
    respond_with(@collection) do |format|
      format.html
    end
  end

  def index
    respond_with(@collection) do |format|
      format.html
    end
  end

  def update
    respond_with(@object) do |format|
      flash[:notice] = "Updated Flash Sale"
      format.html { redirect_to edit_object_url(@object) }
    end
    
  end

  def update
    invoke_callbacks(:update, :before)
    if @object.update_attributes(params[object_name])
      invoke_callbacks(:update, :after)
      flash[:success] = flash_message_for(@object, :successfully_updated)
      respond_with(@object) do |format|
        format.html { redirect_to edit_object_url(@object) }
      end
    else
      invoke_callbacks(:update, :fails)
      respond_with(@object)
    end
  end
  
  def saleables
    search = params[:saleable_type].constantize.search(:name_cont => params[:name])
    render :json => search.result.map(&:name)
  end

  protected
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
