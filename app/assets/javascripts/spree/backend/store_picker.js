$.fn.storeAutocomplete = function (options) {
  'use strict';

  // Default options
  options = options || {};
  var multiple = typeof(options.multiple) !== 'undefined' ? options.multiple : true;

  this.select2({
    minimumInputLength: 2,
    multiple: multiple,
    initSelection: function (element, callback) {
      $.get(Spree.routes.store_search, {
        ids: element.val().split(','),
        token: Spree.api_key
      }, function (data) {
        callback(multiple ? data : data[0]);
      });
    },
    ajax: {
      url: Spree.routes.store_search,
      datatype: 'json',
      data: function (term, page) {
        return {
          q: {
            name_or_url_or_code_cont: term,
          },
          token: Spree.api_key
        };
      },
      results: function (data, page) {
        return {
          results: data
        };
      }
    },
    formatResult: function (store) {
      return store.name;
    },
    formatSelection: function (store) {
      return store.name;
    }
  });
};

$(document).ready(function () {
  $('.store_picker').storeAutocomplete();
});
