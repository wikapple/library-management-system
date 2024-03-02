jQuery(document).ready(function () {
    jQuery('#item-type-selector').change(function () {
        jQuery('#search-media-input').val('');
        const value = jQuery(this).val();
        updateMediaTable(value);
    });
    initializeMediaTypes();

    jQuery('#search-btn').click(function () {
        const searchValue = jQuery('#search-media-input').val();
        const mediaTypeValue = jQuery('#item-type-selector').val();
        updateMediaTable(mediaTypeValue, searchValue);
    });

    jQuery('#search-media-input').keypress(function (event) {
        if (event.which === 13) {
            const searchValue = jQuery('#search-media-input').val();
            const mediaTypeValue = jQuery('#item-type-selector').val();
            updateMediaTable(mediaTypeValue, searchValue);
        }

    });

    jQuery('#clear-search-btn').click(function () {
        jQuery('#search-media-input').val('');
        const mediaTypeValue = jQuery('#item-type-selector').val();
        updateMediaTable(mediaTypeValue);
    });
});

function initializeMediaTypes() {
    const itemTypeSelector = jQuery('#item-type-selector');

    jQuery.ajax({
        url: '/media/types',
        type: 'GET',
        success: function (mediaTypeData) {
            itemTypeSelector.empty();
            for (type of mediaTypeData) {
                itemTypeSelector.append(jQuery('<option>', {
                    value: type.Id,
                    text: type.name
                }));
            }
            itemTypeSelector.find('option').eq(0).prop('selected', true);
            updateMediaTable(itemTypeSelector.find('option').eq(0).val());
        },
        error: function (xhr, status, error) {
            console.error('Error fetching data:', error);
        }
    });
}

function updateMediaTable(mediaTypeSelected, filter = '') {

    jQuery.ajax({
        url: `/media/mediaList/${mediaTypeSelected}?filter=${filter}`,
        method: 'GET',
        success: function (response) {
            jQuery('#media-table tbody').empty();

            jQuery.each(response, function (index, item) {
                var row = jQuery('<tr>');
                row.append(jQuery('<td>').text(item.name));
                row.append(jQuery('<td>').text(item.author));
                row.append(jQuery('<td>').text(item.publisher));
                row.append(jQuery('<td>').text(item.categories.map(x => x.name)));
                row.append(jQuery('<td>').text('0/0'));
                row.append(jQuery('<td>').html('<div class="btn-group" role="group" aria-label="Basic example"><button type="button" class="btn btn-outline-secondary"><i class="fa-solid fa-magnifying-glass"></i></button><button type="button" class="btn btn-outline-info"><i class="fa-solid fa-pen-to-square"></i></button><button type="button" class="btn btn-outline-danger"><i class="fa-solid fa-trash"></i></button></div>'));
                jQuery('#media-table tbody').append(row);
            });
        },
        error: function (xhr, status, error) {
            console.log(error?.message);
        }
    });
}