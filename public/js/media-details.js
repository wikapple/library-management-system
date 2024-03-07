jQuery(document).ready(function () {
jQuery('#confirm-delete-media-btn').click(function() {
    const button = $('#delete-media-btn');
    const mediaIdSelected = button.data('id')
    jQuery.ajax({
        type: 'DELETE',
        url: `api/media/${mediaIdSelected}`,
        success: function(response) {

          jQuery('#delete-confirmation-modal').modal('hide');
          window.location.replace('/media');
        },
        error: function(xhr, status, error) {
          console.error('Error deleting row:', error);
         
        }
      });
});
});