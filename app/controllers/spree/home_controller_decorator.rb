Spree::HomeController.class_eval do
  def index
    @searcher = build_searcher(params)
    @products = @searcher.retrieve_products
    @taxonomies ||= current_store.present? ? Spree::Taxonomy.where(store: current_store) : Spree::Taxonomy
    @taxonomies = @taxonomies.includes(root: :children)
  end
end
