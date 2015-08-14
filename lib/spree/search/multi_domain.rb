module Spree::Search
  class MultiDomain < Spree::Core::Search::Base
    def get_base_scope
      base_scope = Spree::Product.spree_base_scopes.active
      base_scope = base_scope.by_store(store) if store
      base_scope = base_scope.in_taxon(taxon) unless taxon.blank?
      base_scope = get_products_conditions_for(base_scope, keywords)
      base_scope = add_search_scopes(base_scope)
      base_scope = add_eagerload_scopes(base_scope)
      base_scope
    end

    def prepare(params)
      super
      @properties[:store] = Spree::Store.find(params[:store])
    end
  end
end

