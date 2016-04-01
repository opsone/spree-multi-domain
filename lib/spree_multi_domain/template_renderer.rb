module SpreeMultiDomain
  module TemplateRenderer
    def find_layout(layout, locals)
      store_layout = layout

      if @view.respond_to?(:current_store) && @view.current_store && !@view.controller.is_a?(Spree::Admin::BaseController)
        if layout.is_a?(String)
          store_layout = layout.gsub("layouts/", "layouts/#{@view.current_store.code}/")
        else
          store_layout = layout.call.try(:gsub, "layouts/", "layouts/#{@view.current_store.code}/")
        end
      end

      begin
        super(store_layout, locals)
      rescue ::ActionView::MissingTemplate
        super(layout, locals)
      end
    end
  end
end
