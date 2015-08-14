class AddLogoToStores < ActiveRecord::Migration
  def self.up
    add_attachment :spree_stores, :logo
  end

  def self.down
    remove_attachment :spree_stores, :logo
  end
end
