Spree::StoreController.class_eval do

  before_action { prepend_view_path "app/views/#{current_store.code}" }

  protected

    def config_locale
      current_store.default_locale.to_sym
    end

end
