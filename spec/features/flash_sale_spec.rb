require 'spec_helper'

feature "Flash Sale for a taxon" do
  let(:flash_sale) { create(:flash_sale) }

  background do
    visit spree.flash_sale_path(flash_sale)
  end

  scenario "shows the sales name" do
    expect(page).to have_content(flash_sale.name)
  end

  scenario "shows a list of products" do
    expect(page).to have_css(".product", count: 3)
  end

  scenario "has a link to view a product" do
    expect(page).to have_link(product.name)
  end

  scenario "has no products" do
    expect(page).to have_content("There doesn't seem to be any products available")
  end
end
