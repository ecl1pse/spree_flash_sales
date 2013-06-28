require 'spec_helper'

describe Spree::FlashSaleDecorator do
  let(:flash_sale) { build_stubbed(:flash_sale_for_product) }
  let(:decorator) { Spree::FlashSaleDecorator.new(flash_sale) }

  describe "#render_url" do
    context "as a product flash sale" do
      let(:flash_sale) { build_stubbed(:flash_sale_for_product) }
      let(:decorator) { Spree::FlashSaleDecorator.new(flash_sale) }

      it "renders a product url" do
        decorator.render_url.should == spree.product_path(flash_sale.saleable)
      end
    end

    context "as a taxon flash sale" do
      let(:flash_sale) { build_stubbed(:flash_sale) }
      let(:decorator) { Spree::FlashSaleDecorator.new(flash_sale) }

      it "renders a flash sale url" do
        decorator.render_url.should == spree.flash_sale_path(flash_sale)
      end
    end
  end


  describe "#render_image" do
    it "renders an image partial with existing image" do
      image = double(Spree::Image)
      attachment = double("attachment")
      attachment.stub!(:url).and_return("bloop")
      image.stub!(:attachment).and_return(attachment)
      flash_sale.stub(:image).and_return(image)
      decorator.render_image.should match /flash-sale-image/
    end

    it "returns false when no image is present" do
      decorator.render_image.should be_false
    end
  end

end
