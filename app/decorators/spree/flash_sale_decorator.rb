class Spree::FlashSaleDecorator < Draper::Decorator
  delegate_all

  def countdown_format
    object.end_date.strftime(Spree.t("flash_sale.datetimepicker.strftime_format"))
  end

  def countdown_layout
    "{dn} DAYS {hnn}{sep}{mnn}{sep}{snn}"
  end

  def render_url
    if object.product?
      h.spree.product_path(object.saleable)
    else
      h.spree.flash_sale_path(object)
    end
  end

  def render_image
    if object.image.present?
      h.render(partial: 'spree/flash_sales/image', locals: {flash_sale: object.decorate})
    end
  end

end
