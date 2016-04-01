class SpreeMultiDomain::Search < Spree::Core::Search::Base
  attr_accessor :current_store

  def initialize(params)
    super
    self.current_store = Spree::Store.default
  end

  def get_base_scope
    base_scope = Spree::Product.spree_base_scopes.by_store(current_store).active
    base_scope = base_scope.in_taxon(taxon) unless taxon.blank?
    base_scope = get_products_conditions_for(base_scope, keywords)
    base_scope = add_search_scopes(base_scope)
    base_scope = add_eagerload_scopes(base_scope)
    base_scope
  end
end
