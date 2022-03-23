$(document).ready(function() {

  $('body').on('change', '.batch-search-filter', function() {
    start_date = $('#batch-search-start-date').val();
    end_date   = $('#batch-search-end-date').val();
    constraint = $('#batch-search-constraint').val();

    $.ajax({
      url:      'batches/',
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
