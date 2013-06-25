require 'spec_helper'

feature "Flash Sale for a taxon" do
  given!(:flash_sale) { create(:flash_sale) }
  given!(:product) { flash_sale.saleable.products.first }

  background do
    visit spree.flash_sale_path(flash_sale)
  end

  scenario "shows the sales name" do
    expect(page).to have_content(flash_sale.name)
  end

  scenario "shows a list of products" do
    expect(page).to have_css(".flash-sale-product", count: flash_sale.saleable.products.size)
  end

  scenario "has a link to view a product" do
    expect(page).to have_link(product.name)
  end

  scenario "link to product goes to product" do
    find_link(product.name).click
    current_path.should == spree.product_path(product) # should go to the product directly
  end

end

feature "Flash Sale Page: no products" do
  given!(:flash_sale) { create(:flash_sale) }

  scenario "has no products" do
    flash_sale.saleable.products.each(&:destroy)
    visit spree.flash_sale_path(flash_sale)
    expect(page).to have_content("There doesn't seem to be any products available")
  end
end
