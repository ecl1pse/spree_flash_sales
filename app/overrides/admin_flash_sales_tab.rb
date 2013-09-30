Deface::Override.new(
            :name => "admin_flash_sales_tab",
            :virtual_path => "spree/admin/shared/menu",
            :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
            :text => "<%= tab :flash_sales, :icon => 'icon-th-list' %>"
)
