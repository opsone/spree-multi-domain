class AddPhoneAndPromoToStores < ActiveRecord::Migration
  def up
    add_column :spree_stores, :phone, :string
    add_column :spree_stores, :advertisement, :text
    Spree::Store.add_translation_fields! advertisement: :text
  end
  def down
    remove_column :spree_stores, :phone
    remove_column :spree_stores, :advertisement
    remove_column :spree_store_translations, :advertisement
  end
end
