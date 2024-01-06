module SpreeCompanyCustomer
  module CoreExt
    module Spree
      module AddressWithCompanyInfo
        def self.prepended(base)
          base.validates :company_enabled, inclusion: [true, false]
          base.validates :company_vat_registered, inclusion: [true, false]

          base.before_validation :remove_company_info, unless: :company_enabled

          base.whitelisted_ransackable_attributes ||= []
          base.whitelisted_ransackable_attributes += %w(company_enabled company_vat_id company_vat_registered)
        end

        def remove_company_info
          self.company = nil
          self.company_vat_id = nil
          self.company_vat_registered = false
        end
      end
    end
  end
end