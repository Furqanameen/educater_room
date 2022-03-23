$(document).ready(function() {

  $('body').on('change','.student-search-filter',function(){
    constraint = $('#student-search-constraint').val();

    $.ajax({
      url:      'students/',
      type:     'GET',
      dataType: 'script',
      data: {
        filter : {
          constraint: constraint
        }
      }
    });
  })

});
