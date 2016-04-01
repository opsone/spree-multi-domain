module SpreeMultiDomain
  module ControllerHelpers
    def build_searcher(params)
      Spree::Config.searcher_class.new(params).tap do |searcher|
        searcher.current_user = try_spree_current_user
        searcher.current_currency = current_currency
        searcher.current_store = current_store
      end
    end
  end
end
