$(document).ready(function() {


  if($('.sections > .nested-fields').length > 0){
    $('.sections > .nested-fields').each(function(){
      update_course_options($(this).find('.course_sections'));
    });
  }
  else if($('.courses_portion .course_sections').length > 0){
    update_course_options($('.course_sections'));
  }

  $('body').on('click', '.course-select', function(){
    update_course_options($(this).parents('.course_sections'));
  })

  $('body').on('change', '.course-select', function(){
    update_course_options($(this).parents('.course_sections'));
  })

  $(document).on('cocoon:after-insert', '.courses_portion .course_sections', function() {
    update_course_options($(this));
  })

  $(document).on('cocoon:after-remove', '.courses_portion .course_sections', function() {
    update_course_options($(this));
  });

  function update_course_options(fields){
    var selected_courses = [];
    fields.children('.nested-fields').each(function(){
      key             = $(this).find('.course-select:visible option:selected').val()
      has_key         = $.inArray(key, selected_courses);
      if (key != "" && (has_key == -1)){selected_courses.push(key);}
    });

    fields.children('.course_sections .nested-fields').each(function(){
      $(this).find('.course-select option').filter(function () {
        return $.inArray($(this).val(), selected_courses) == -1
      }).show();

      $(this).find('.course-select option').filter(function () {
        return $.inArray($(this).val(), selected_courses) !== -1
      }).hide();
    });
  }

});
