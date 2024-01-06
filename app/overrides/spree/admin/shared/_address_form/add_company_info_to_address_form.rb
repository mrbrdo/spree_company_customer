Deface::Override.new(
  virtual_path:  'spree/admin/shared/_address_form',
  name:          'add_company_info_to_address_form',
  insert_before: Deface.erb_contains('elsif field == "state"'),
  text: <<-HTML
    <% elsif field == "company" %>
      <% ['company', 'company_vat_id'].each do |f_field| %>
        <%= field_container (s_or_b + '_' + f_field), nil, class: ["#\{type}-row"] do %>
          <%= f.label f_field, I18n.t("activerecord.attributes.spree/address.#\{f_field}") %>
          <%= f.text_field f_field, class: 'form-control' %>
          <%= error_message_on f.object, f_field %>
        <% end %>
      <% end %>
      <%= field_container (s_or_b + '_' + 'company_vat_registered'), nil, class: ["#\{type}-row"] do %>
        <%= f.check_box 'company_vat_registered', class: 'checkbox' %>
        <%= f.label 'company_vat_registered', I18n.t("activerecord.attributes.spree/address.company_vat_registered"), class: 'form-check-label' %>
        <%= error_message_on f.object, 'company_vat_registered' %>
      <% end %>
  HTML
)
