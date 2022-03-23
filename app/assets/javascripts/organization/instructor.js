$(document).ready(function() {

  $('body').on('change', '.instructor-search-filter', function() {
    constraint = $('#instructor-search-constraint').val();

    $.ajax({
      url:      'instructors/',
      type:     'GET',
      dataType: 'script',
      data: { 
        filter : {
          constraint: constraint
        }
      }
    });
  });

});
