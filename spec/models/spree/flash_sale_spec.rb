require 'spec_helper'

describe Spree::FlashSale do

  it { should belong_to :saleable }

  it { should validate_presence_of :name }
  it { should validate_presence_of :start_date }
  it { should validate_presence_of :end_date }
  it { should validate_presence_of :active }

  describe "FlashSale::live" do
    before do
      create_list(:flash_sale, 3)
    end

    it "returns a collection of live flash_sales" do
      Spree::FlashSale.live.each do |flash_sale|
        flash_sale.live?.should == true
      end
    end
  end

  describe "#live?" do

    context "todays date and time is between #start_date and #end_date" do
      let(:flash_sale) { create(:flash_sale, start_date: DateTime.now.in_time_zone.beginning_of_day, end_date: 1.day.from_now.in_time_zone) }
      subject { flash_sale }

      its(:live?) { should == true }

      context "not active" do
        it "won't be live" do
          flash_sale.active = false
          flash_sale.save
          flash_sale.live?.should == false
        end
      end
    end

    context "today's date is right but time is later than #start_date" do
      let(:flash_sale) { create(:flash_sale, start_date: 3.hours.from_now.in_time_zone, end_date: 1.day.from_now.in_time_zone) }
      subject { flash_sale }

      its(:live?) { should == false }
    end

    context "today's date is before #start_date" do
      let(:flash_sale) { create(:flash_sale, start_date: 1.day.from_now.in_time_zone) }
      subject { flash_sale }

      its(:live?) { should == false }
    end

    context "today's date is after #end_date" do
      let(:flash_sale) { create(:flash_sale, start_date: 2.days.ago.in_time_zone, end_date: 1.day.ago.in_time_zone) }
      subject { flash_sale }

      its(:live?) { should == false }
    end

  end

  describe "#to_param" do
    let(:flash_sale) { create(:flash_sale, name: 'cool-sale-bro') }

    it "has a pretty url" do
      flash_sale.to_param.should == "#{flash_sale.id}-cool-sale-bro"
    end

    it "should still be able to find by id" do
      Spree::FlashSale.find(flash_sale).should == flash_sale
    end

  end

  describe "adding an image" do
    pending "need the ability to add an image"
  end
end
