jQuery(document).ready(function () {
    jQuery('#media-type-selector').change(function () {
        jQuery('#search-media-input').val('');
        const value = jQuery(this).val();
        jQuery('#item-type-modal-selector').val(value);
        updateMediaTable(value);
    });

    updateMediaTable(jQuery('#media-type-selector').val());
    
    jQuery('#search-btn').click(function () {
        const searchValue = jQuery('#search-media-input').val();
        const mediaTypeValue = jQuery('#media-type-selector').val();
        updateMediaTable(mediaTypeValue, searchValue);
    });

    jQuery('#search-media-input').keypress(function (event) {
        if (event.which === 13) {
            const searchValue = jQuery('#search-media-input').val();
            const mediaTypeValue = jQuery('#media-type-selector').val();
            updateMediaTable(mediaTypeValue, searchValue);
        }

    });

    jQuery('#clear-search-btn').click(function () {
        jQuery('#search-media-input').val('');
        const mediaTypeValue = jQuery('#media-type-selector').val();
        updateMediaTable(mediaTypeValue);
    });

    let mediaIdSelected;
    let rowSelected;
    
    jQuery(document).on('click', '.delete-media-btn', function () {
        mediaIdSelected = jQuery(this).data('id');
        rowSelected = jQuery(this).closest('tr');
    });

    jQuery('#confirm-delete-media-btn').click(function() {
        jQuery.ajax({
            type: 'DELETE',
            url: `api/media/${mediaIdSelected}`,
            success: function(response) {
                rowSelected.addClass('removing'); 
                
                setTimeout(function() {
                  rowSelected.remove(); 
                }, 500); 

              jQuery('#delete-confirmation-modal').modal('hide');

            },
            error: function(xhr, status, error) {
              console.error('Error deleting row:', error);
             
            }
          });
    });
});

function updateMediaTable(mediaTypeSelected, filter = '') {

    jQuery.ajax({
        url: `api/media/list/${mediaTypeSelected}?filter=${filter}`,
        method: 'GET',
        success: function (response) {
            jQuery('#media-table tbody').empty();

            jQuery.each(response, function (index, item) {
                var row = jQuery('<tr>');
                row.append(jQuery('<td>').text(item.name));
                row.append(jQuery('<td>').text(item.author));
                row.append(jQuery('<td>').text(item.publisher));
                row.append(jQuery('<td>').text(item.categories.map(x => x.name).join(', ')));
                row.append(jQuery('<td>').text('0 / 0'));
                row.append(jQuery('<td>').html(`<a href="/media/${item.id}" class="btn btn-outline-info"><i class="fa-solid fa-circle-info"></i> View Details</button>`));
                jQuery('#media-table tbody').append(row);
            });
        },
        error: function (xhr, status, error) {
            console.log(error?.message);
        }
    });
}