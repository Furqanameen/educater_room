$(document).ready(function() {

  $('body').on('change', '.assignment-search-filter', function() {
    start_date = $('#assignment-search-start-date').val();
    end_date   = $('#assignment-search-end-date').val();
    constraint = $('#assignment-search-constraint').val();

    $.ajax({
      url:      'assignments/',
      type:     'GET',
      dataType: 'script',
      data: {
        filter : {
          start_date : start_date,
          end_date   : end_date,
          constraint : constraint
        }
      }
    });
  });

});
