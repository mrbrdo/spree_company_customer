Dir[File.join(__dir__, 'core_ext', '**', '*.rb')].each { |f| require f }

module SpreeCompanyCustomer
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_company_customer'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer "let the main autoloader ignore this engine's overrides" do
      overrides = root.join("app/overrides")
      Rails.autoloaders.main.ignore(overrides)
    end

    def self.activate
      # enable Spree Core company field for Address
      ::Spree::Config.company = true
      ::Spree::PermittedAttributes.address_attributes.concat([:company_enabled, :company_vat_id, :company_vat_registered])
      ::Spree::Address.prepend SpreeCompanyCustomer::CoreExt::Spree::AddressWithCompanyInfo

      Dir.glob(File.join(File.dirname(__FILE__), "../../app/overrides/*.rb")) do |c|
        load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
