require 'spec_helper'

feature "Home" do
  background do
    # 3.times do
    #   create(:flash_sale)
    # end
    create_list(:flash_sale, 3)

    visit spree.root_path
  end

  let(:inactive_flash_sale) { create(:inactive_flash_sale) }

  scenario "displays a notice if there's no active flash sales" do
    expect(page).to have_content "There are no active sales at the moment. Check back soon!"
  end

  scenario "shows a list of live flash sales" do
    expect(page).to have_css(".flash_sale", count: 3)
  end

  scenario "does not list inactive flash sales" do
    expect(page).to_not have_content(inactive_flash_sale.name)
  end

  context "clicking a flash sale for a product" do
    let(:product_sale) { create(:active_sale_for_product) }

    scenario "takes you to the product page" do
      find_link(product_sale.name).click
      current_path.should == spree.product_path(product_sale)
    end
  end

  context "clicking a flash sale for a taxon" do
    let(:taxon_sale) { create(:flash_sale) }

    scenario "takes you to flash sale page" do
      find_link(taxon_sale.name).click
      current_path.should == spree.flash_sale_path(taxon_sale)
    end
  end
end
