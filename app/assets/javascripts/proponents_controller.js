$(document).on('turbolinks:load', function() {
  $('#proponent-form').submit(function(event) {
    event.preventDefault();
    var formData = $(this).serialize();

    $.ajax({
      url: $(this).attr('action'),
      method: $(this).attr('method'),
      data: formData,
      success: function(response) {
      },
      error: function(xhr, status, error) {
      }
    });
  });
});