Spree::BaseController.class_eval do

  before_action { prepend_view_path "app/views/#{current_store.code}" }

  helper_method :current_tracker

  def current_tracker
    @current_tracker ||= Spree::Tracker.current(request.env['SERVER_NAME'])
  end

  def current_currency
    current_store.default_currency || Spree::Config[:currency]
  end

end
