Spree::TaxonsController.class_eval do
   def show
    @taxon = Spree::Taxon.find_by_store_id_and_permalink!(current_store.id, params[:id])
    return unless @taxon

    @searcher = build_searcher(params.merge(taxon: @taxon.id))
    @products = @searcher.retrieve_products
    @taxonomies ||= current_store.present? ? Spree::Taxonomy.where(store: current_store) : Spree::Taxonomy
    @taxonomies = @taxonomies.includes(root: :children)
  end
end
