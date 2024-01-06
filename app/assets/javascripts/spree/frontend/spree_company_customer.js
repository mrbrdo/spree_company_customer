Spree.ready(function($) {
  $('#order_bill_address_attributes_company_enabled').change(function() {
    $(this).
    parents(".checkout_address_company_info").
    find(".checkout_address_company_field").
    toggle(this.checked);
  });
});