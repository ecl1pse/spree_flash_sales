require 'spec_helper'

describe Spree::FlashSale do

  it { should belong_to :saleable }

  it { should validate_presence_of :name }
  it { should validate_presence_of :start_date }
  it { should validate_presence_of :end_date }
  it { should validate_presence_of :permalink }
  it { should validate_presence_of :active }

  # describe "creating" do
  # end

  describe "adding an image" do
    pending "need the ability to add an image"
  end
end
