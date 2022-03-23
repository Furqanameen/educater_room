$(document).ready(function() {
  flatpickr('.flat-date')

  $('.flatpickr-datetime').flatpickr(
    {
      enableTime: true,
      time_24hr: true
    })

  $('.select2').select2({
    placeholder: 'Select option'
  });

  $(".user-form-validation").parsley({trigger: "change keyup"});

});
