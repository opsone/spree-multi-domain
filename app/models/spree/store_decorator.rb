module Spree
  Store.class_eval do
    has_and_belongs_to_many :products, :join_table => 'spree_products_stores'
    has_many :taxonomies
    has_many :orders

    has_many :store_payment_methods
    has_many :payment_methods, :through => :store_payment_methods

    has_many :store_shipping_methods
    has_many :shipping_methods, :through => :store_shipping_methods

    has_and_belongs_to_many :promotion_rules, :class_name => 'Spree::Promotion::Rules::Store', :join_table => 'spree_promotion_rules_stores', :association_foreign_key => 'promotion_rule_id'

    has_attached_file :logo,
      :styles => { :mini => '48x48>', :small => '100x100>', :medium => '250x250>' },
      :default_style => :medium,
      default_url: '/default/stores/noimage.png',
      url: '/stores/:id/:style/:basename.:extension',
      path: ':rails_root/public/stores/:id/:style/:basename.:extension',
      convert_options: { :all => '-strip -auto-orient' }

    validates_attachment :logo, :content_type => { :content_type => %w(image/jpeg image/jpg image/png image/gif) }

  end
end
