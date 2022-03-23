var multiStepWizardSignUp=function(){
  var form = $("#signup-form");

  if (form.length > 0) {
    form.validate({
      errorPlacement: function errorPlacement(error, element) { element.before(error); },
      rules: {
        'user[password]': {
          minlength: 6
        },
        'user[organization_attributes][name]':{
          required: true
        },
        'user[organization_attributes][additional_information][address]':{
          required: true
        },
        'user[organization_attributes][additional_information][education][]': {
          required: true
        },
        'user[organization_attributes][additional_information][specialization][]': {
          required: true
        }
      },
      messages: {
        'user[organization_attributes][name]':{
          required: "This field is required"
        },
        'user[organization_attributes][additional_information][address]':{
          required: "This field is required"
        },
        'user[organization_attributes][additional_information][education][]': {
          required: "You must check atleast one box"
        },
        'user[organization_attributes][additional_information][specialization][]': {
          required: "You must check atleast one box"
        }
      }
    });

    form.steps({
      headerTag: "h6",
      bodyTag: "section",
      transitionEffect: "fade",
      titleTemplate: '<span class="step">#title#</span>',
      labels: {
        current: "current step:",
        pagination: "Pagination",
        finish: "Finish",
        next: "Next Step >",
        previous: "< Back to Login",
        loading: "Loading ..."
      },
      onStepChanging: function(e, currentIndex, priorIndex) {
        form.validate().settings.ignore = ":disabled,:hidden";
        return form.valid();
      },
      onFinishing: function(e, currentIndex, priorIndex) {
        form.validate().settings.ignore = ":disabled,:hidden";
        return form.valid();
      },
      onFinished: function (event, currentIndex) {
        $("#signup-form").submit();
      }
    });
  }
}


$(document).ready(function(){
  multiStepWizardSignUp();
  AOS.init();
  setTimeout(function() { $('.main-loader').removeClass('d-flex').addClass('d-none') }, 1500);

  /* Main Navigation Scrolling only for Home Page */
  if ( $('.home-page-container').length > 0 ) {
    $('body').scrollspy({target: "#header", offset: 120});
    $("#header a.nav-link, #default-drawer a.d-inline-block").on('click', function(event) {
      if (this.hash !== "" && this.hash[0] === "#") {
        offsetValue = $(this).hasClass('nav-link') ? 120 : 60;
        event.preventDefault();
        var hash = this.hash;
        $("#header .nav-item, #default-drawer .sidebar-menu-item").removeClass('active');
        $(this).parent().addClass('active');
        setTimeout(function() {
          $(window).scrollTop($(hash).offset().top - offsetValue)
        }, 100);
      }
    });
  }

  var a = new StickySidebar('#sidebar', {
    topSpacing: 150,
    bottomSpacing: 20,
    containerSelector: '.container',
    innerWrapperSelector: '.theiaStickySidebar'
  });

  $("#sidebar li a").on('click', function(event) {
    $("#sidebar li a").removeClass('active');
    $(this).addClass('active');
  });

});
