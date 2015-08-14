Spree::Order.class_eval do
  belongs_to :store
  scope :by_store, -> (store) { where(store_id: store) }

  def available_payment_methods
    @available_payment_methods ||= Spree::PaymentMethod.available(:front_end, store)
  end
end
