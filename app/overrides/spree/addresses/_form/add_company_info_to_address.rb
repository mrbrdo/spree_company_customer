Deface::Override.new(
  virtual_path:  'spree/addresses/_form',
  name:          'add_company_info_to_address_2',
  replace: Deface.erb_contains('next if field == "company"'),
  text: <<-HTML
    <% next if field == "company" %>
    HTML
  )

Deface::Override.new(
  virtual_path:  'spree/addresses/_form',
  name:          'add_company_info_to_address',
  insert_after: Deface.erb_contains('Spree::Address::ADDRESS_FIELDS.each'),
  text: <<-HTML

    <% if field == "company" %>
      <div class="checkout_address_company_info">
        <div class="form-group mb-4">
          <div class="spree-checkbox-container checkout-content-billing-checkbox">
            <div class="spree-checkbox">
              <%= address_form.check_box :company_enabled, { class: 'form-check-input'} %>
              <%= label_tag :"order_#\{address_name}_attributes_company_enabled", nil %>
            </div>
            <%= label_tag :"order_#\{address_name}_attributes_company_enabled", I18n.t("activerecord.attributes.spree/address.company_enabled"), class: 'spree-checkbox-label' %>
          </div>
        </div>

        <% field_style = (address_form.object.company_enabled ? "" : "display: none") %>
        <div class="form-group mb-4 checkout_address_company_field" style="<%= field_style %>">
          <%= address_field(address_form, :company, address_id) %>
        </div>

        <div class="form-group mb-4 checkout_address_company_field" style="<%= field_style %>">
          <%= address_field(address_form, :company_vat_id, address_id) %>
        </div>

        <div class="form-group mb-4 checkout_address_company_field" style="<%= field_style %>">
          <div class="spree-checkbox-container checkout-content-billing-checkbox">
            <div class="spree-checkbox">
              <%= address_form.check_box :company_vat_registered, { class: 'form-check-input'} %>
              <%= label_tag :"order_#\{address_name}_attributes_company_vat_registered", nil %>
            </div>
            <%= label_tag :"order_#\{address_name}_attributes_company_vat_registered", I18n.t("activerecord.attributes.spree/address.company_vat_registered"), class: 'spree-checkbox-label' %>
          </div>
        </div>
      </div>
    <% end %>

        HTML
)
