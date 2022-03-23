$(document).ready(function() {

  $('body').on('change', '.course-search-filter', function() {
    constraint = $('#course-search-constraint').val();

    $.ajax({
      url:      'courses/',
      type:     'GET',
      dataType: 'script',
      data: {
        filter: {
          constraint: constraint
        }
      }
    });
  });

});
