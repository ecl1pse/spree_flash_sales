require 'spec_helper'

formatted_expectation = '%Y/%m/%d %H:%M:%S %z'


feature 'Admin' do
  stub_authorization!

  given!(:flash_sale) { create(:flash_sale) }
  given!(:flash_sale_b) { create(:flash_sale) }
  given!(:product) { create(:product) }

  background do
    sign_in_as!(create(:admin_user))
    visit spree.admin_path
    click_link "Flash Sales"
  end

  scenario "Clicking admin tab" do
    find_link("Flash Sales").click
    current_path.should == spree.admin_flash_sales_path
  end

  scenario "Viewing a list of flash sales" do
    visit spree.admin_flash_sales_path
    expect(page).to have_css(".flash-sale", count: Spree::FlashSale.all.size)
  end

  scenario "Viewing a flash sale" do
    visit spree.admin_flash_sales_path
    click_link flash_sale.name
    current_path.should == spree.edit_admin_flash_sale_path(flash_sale)
  end

  context "creating a flash sale" do
    pending ""
  end

  context "editing a flash sale" do
    background do
      click_link flash_sale.name
    end

    scenario "name" do
      fill_in "flash_sale_name", with: 'Some Flash Sale'
      click_button 'Update'
      find_field("flash_sale_name").value.should == 'Some Flash Sale'
    end

    scenario "start date" do
      date = 1.day.ago.in_time_zone
      fill_in "flash_sale_start_date", with: date
      click_button 'Update'
      find_field("flash_sale_start_date").value.should == date.strftime(formatted_expectation)
    end

    scenario "end date" do
      date = 3.days.from_now.in_time_zone
      fill_in "flash_sale_end_date", with: date
      click_button 'Update'
      find_field("flash_sale_end_date").value.should == date.strftime(formatted_expectation)
    end

    scenario "active" do
      check('Active')
      click_button 'Update'
      find_field("Active").value.should == "1"
    end

    scenario 'saleable' do
      select('Product', :from => 'flash_sale_saleable_type')
      fill_in "flash_sale_saleable_name", with: product.name
      click_button 'Update'
      find_field("flash_sale_saleable_name").value.should == product.name
    end

  end

  context "searching flash sales" do
    it "should display the correct results for a flash sale search" do
      fill_in "q_name_cont", :with => flash_sale.name
      click_button "Search"
      within("table#listing_flash_sales") do
        page.should have_content flash_sale.name
        page.should_not have_content flash_sale_b.name
      end
    end
  end
end

feature "Flash Sale Images" do
  stub_authorization!
  given!(:flash_sale) { create(:flash_sale) }

  let(:file_path) { Rails.root + "../../spec/support/ror_ringer.jpeg" }

  before do
    # Ensure attachment style keys are symbolized before running all tests
    # Otherwise this would result in this error:
    # undefined method `processors' for \"48x48>\
    Spree::Image.attachment_definitions[:attachment][:styles].symbolize_keys!
  end

  context "uploading and editing an image" do
    it "should allow an admin to upload and edit an image for a product" do
      Spree::Image.attachment_definitions[:attachment].delete :storage

      create(:product)

      visit spree.admin_path
      click_link "Flash Sales"
      click_link flash_sale.name
      attach_file('flash_sale_attachment', file_path)
      click_button "Update"
      expect(page).to have_content("successfully updated!")
      expect(page).to have_css(".flash-sale-image")
    end
  end
end
