$(document).ready(function() {

  $('body').on('change', '.section-search-filter', function() {
    batch      = $('#section-search-batch').val();
    constraint = $('#section-search-constraint').val();

    $.ajax({
      url:      'sections/',
      type:     'GET',
      dataType: 'script',
      data: {
        filter: {
          batch:      batch,
          constraint: constraint
        }
      }
    });
  });

});
