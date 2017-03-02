Spree::StoreController.class_eval do

  protected

    def config_locale
      current_store.default_locale.to_sym
    end

end
