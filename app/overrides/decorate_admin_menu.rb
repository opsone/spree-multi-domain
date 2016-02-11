Deface::Override.new(
  virtual_path: 'spree/layouts/admin',
  name: 'stores_admin_sidebar_menu',
  insert_bottom: '#main-sidebar',
  partial: 'spree/admin/shared/stores_sidebar_menu'
)
