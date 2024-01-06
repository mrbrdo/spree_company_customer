class AddCompanyInfoToSpreeAddresses < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_addresses, :company_enabled, :boolean, null: false, default: false
    add_column :spree_addresses, :company_vat_id, :string
    add_column :spree_addresses, :company_vat_registered, :boolean, null: false, default: false
  end
end
