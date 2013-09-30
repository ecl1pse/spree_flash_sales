Deface::Override.new(
            :name => "admin_flash_sales_tab",
            :virtual_path => "spree/admin/shared/_menu",
            :insert_bottom => "[data-hook='admin_tabs']",
            :text => "<%= tab :flash_sales, :icon => 'icon-th-list' %>"
)
