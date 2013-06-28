Deface::Override.new(:virtual_path => 'spree/home/index',
  :name => 'replace_products_with_flash_sales',
  :replace => "[data-hook='homepage_products']",
  :text => "
    <section class='flash-sales' data-hook='homepage_flash_sales'>
      <%= render partial: 'spree/flash_sales/flash_sale', collection: flash_sales %>
    </section>
    <% if flash_sales.blank? %>
     <p class='notice'>There are no active sales at the moment. Check back soon!</p>
    <% end %>
  ")
