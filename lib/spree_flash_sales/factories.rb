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

  factory :taxon_with_products do 
    generate(:saleable_taxon)
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

  factory :new_user, class: Spree::User do
    email { generate(:random_email) }
    login { email }
    password 'secret'
    password_confirmation { password }
    authentication_token { generate(:user_authentication_token) } if Spree.user_class.attribute_method? :authentication_token

    factory :new_admin_user do
      spree_roles { [Spree::Role.find_by_name('admin') || create(:role, name: 'admin')] }
    end
  end
end
