module SpreeMultiDomain
  class Engine < Rails::Engine
    engine_name 'spree_multi_domain'

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end

      # Spree::Config.searcher_class = Spree::Search::MultiDomain
      # ApplicationController.send :include, SpreeMultiDomain::MultiDomainHelpers
    end

    config.to_prepare &method(:activate).to_proc

    initializer "templates with dynamic layouts" do |app|
      ActionView::TemplateRenderer.class_eval do
        def find_layout_with_multi_store(layout, locals)
          store_layout = layout

          if @view.respond_to?(:current_store) && @view.current_store && !@view.controller.is_a?(Spree::Admin::BaseController)
            store_layout = if layout.is_a?(String)
              layout.gsub("layouts/", "layouts/#{@view.current_store.code}/")
            else
              layout.call.try(:gsub, "layouts/", "layouts/#{@view.current_store.code}/")
            end
          end

          begin
            find_layout_without_multi_store(store_layout, locals)
          rescue ::ActionView::MissingTemplate
            find_layout_without_multi_store(layout, locals)
          end
        end

        alias_method_chain :find_layout, :multi_store
      end
    end

    initializer 'spree.promo.register.promotions.rules' do |app|
      app.config.spree.promotions.rules << Spree::Promotion::Rules::Store
    end
  end
end
