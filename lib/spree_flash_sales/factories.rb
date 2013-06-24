FactoryGirl.define do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'spree_flash_sales/factories'

  sequence(:sale_name) { |n| "Flash Sale - #{n}" }

  sequence(:saleable_product) { FactoryGirl.create(:product) }

  ## Create a taxon with multiple products
  sequence :saleable_taxon do |n|
    number = n+Random.rand(3)

    FactoryGirl.create(:taxon) do |taxon|
      taxon.products << FactoryGirl.create_list(:product, number)
    end
  end

  trait :inactive do
    active false
  end

  trait :product_as_saleable do
    saleable { generate(:saleable_product) }
  end


  factory :flash_sale, class: Spree::FlashSale do
    ## By default associate a flash sale with a taxon.
    saleable { generate(:saleable_taxon) }

    active true
    name { generate(:sale_name) }
    start_date DateTime.now.in_time_zone
    end_date 2.weeks.from_now

    factory :inactive_flash_sale, :traits => [:inactive]
    factory :flash_sale_for_product, :traits => [:product_as_saleable]
  end
end
