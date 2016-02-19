Spree::Admin::SearchController.class_eval do
  def stores
    if params[:ids]
      @stores = Spree::Store.where(id: params[:ids].split(',').flatten)
    else
      @stores = Spree::Store.ransack(params[:q]).result.limit(10)
    end
  end
end
