$(document).ready(function() {

  $('body').on('change', '.lesson-search-filter', function() {
    constraint = $('#lesson-search-constraint').val();

    $.ajax({
      url:      'lessons/',
      type:     'GET',
      dataType: 'script',
      data: {
        filter : {
          constraint : constraint
        }
      }
    });
  });

});
