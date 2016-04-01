module SpreeMultiDomain
  class Engine < Rails::Engine
    engine_name 'spree_multi_domain'

    config.autoload_paths += %W(#{config.root}/lib)

    initializer "templates with dynamic layouts" do |app|
      ActionView::TemplateRenderer.send(:prepend, SpreeMultiDomain::TemplateRenderer)
    end

    initializer "add store permitted_attributes" do |app|
      Spree::PermittedAttributes.store_attributes.push :default_locale
    end

    initializer "add current_store to build_searcher" do |app|
      Spree::Config.searcher_class = SpreeMultiDomain::Search

      Spree::Core::ControllerHelpers::Search.send(:prepend, SpreeMultiDomain::ControllerHelpers)
    end

    initializer "register store promotion rule" do |app|
      app.config.spree.promotions.rules << Spree::Promotion::Rules::Store
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
