class AddPhoneAndPromoToStores < ActiveRecord::Migration
  def up
    add_column :spree_stores, :phone, :string
    add_column :spree_stores, :advertisment, :text
    Spree::Store.add_translation_fields! advertisment: :text
  end
  def down
    remove_column :spree_stores, :phone
    remove_column :spree_stores, :advertisment
    remove_column :spree_store_translations, :advertisment
  end
end
