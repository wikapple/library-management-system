jQuery(document).ready(function () {
    jQuery('#item-type-selector').change(function () {
        jQuery('#search-media-input').val('');
        const value = jQuery(this).val();
        jQuery('#item-type-modal-selector').val(value);
        updateMediaTable(value);
    });
    initializeMediaTypes();
    initializeCategories();

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

    jQuery('#exampleModal').on('hidden.bs.modal', function () {
        jQuery('#create-or-update-form')[0].reset();
    });

    jQuery('#submit-create-or-update-modal-btn').click(function() {
        jQuery('#create-or-update-form').submit();
    });

    jQuery('#create-or-update-form').submit(function(event) {
        event.preventDefault();

        if(this.checkValidity() === false) {
            event.stopPropagation();
        } else {
            jQuery.ajax({
                type: 'POST',
                url: '/media',
                data: jQuery('#create-or-update-form').serialize(),
                success: function(response) {
                    console.log("media add successful");
                    updateMediaTable(jQuery('#item-type-selector').val());
                },
                error: function(xhr, status, error) {
                    console.error('Failed to add or update media');
                }
            });
        }
        jQuery(this).addClass('was-validated');
        jQuery('#exampleModal').modal('hide');
    });
});

function initializeMediaTypes() {
    const itemTypeSelector = jQuery('#item-type-selector');
    const itemTypeModalSelector = jQuery('#item-type-modal-selector');
    jQuery.ajax({
        url: '/media/types',
        type: 'GET',
        success: function (mediaTypeData) {
            itemTypeSelector.empty();
            itemTypeModalSelector.empty();
            for (type of mediaTypeData) {
                itemTypeSelector.append(jQuery('<option>', {
                    value: type.Id,
                    text: type.name
                }));
                itemTypeModalSelector.append(jQuery('<option>', {
                    value: type.Id,
                    text: type.name
                }));
            }
            itemTypeSelector.find('option').eq(0).prop('selected', true);
            itemTypeModalSelector.find('option').eq(0).prop('selected', true);
            updateMediaTable(itemTypeSelector.find('option').eq(0).val());
        },
        error: function (xhr, status, error) {
            console.error('Error fetching data:', error);
        }
    });
}
function initializeCategories() {
    const modalCategoriesSelector = jQuery('#categories-modal-selector');
    jQuery.ajax({
        url: '/media/categories',
        type: 'GET',
        success: function (categoryData) {
            modalCategoriesSelector.empty();
            for (category of categoryData) {
                modalCategoriesSelector.append(jQuery('<option>', {
                    value: category.id,
                    text: category.name
                }));
            }
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
                row.append(jQuery('<td>').html('<div class="btn-group" role="group" aria-label="Basic example"><button type="button" class="btn btn-outline-secondary"><i class="fa-solid fa-circle-info"></i></button><button type="button" class="btn btn-outline-info"><i class="fa-solid fa-pen-to-square"></i></button><button type="button" class="btn btn-outline-danger"><i class="fa-solid fa-trash"></i></button></div>'));
                jQuery('#media-table tbody').append(row);
            });
        },
        error: function (xhr, status, error) {
            console.log(error?.message);
        }
    });
}