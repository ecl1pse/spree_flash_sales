require 'spec_helper'

describe Spree::FlashSale do

  it { should belong_to :saleable }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :start_date }
  it { should validate_presence_of :end_date }
  it { should validate_presence_of :active }
  it { should validate_presence_of :permalink }

  describe "#live" do
    it "is live if today's date is between #start_date and #end_date" do
      pending 'needs specs'
    end

     it "is not live if today's date is before #start_date" do
      pending 'needs specs'
     end

     it "is not live if todays date is after #end_date" do
      pending 'needs specs'
     end
  end

  describe "#update_permalink" do
    let(:flash_sale) { create(:flash_sale, name: 'cool-sale-bro') }

    subject { flash_sale }

    its(:permalink) { should == "cool-sale-bro" }

    describe "changing name" do

      it "updates the permalink" do
        flash_sale.name = 'updated-cool-sale-bro'
        flash_sale.save
        flash_sale.name.should == "updated-cool-sale-bro"
      end
    end
  end

  describe "adding an image" do
    pending "need the ability to add an image"
  end
end
