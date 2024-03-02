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

    jQuery('#add-media-modal').on('hidden.bs.modal', function () {
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
        jQuery('#add-media-modal').modal('hide');
    });

    let mediaIdSelected;
    let rowSelected;
    jQuery(document).on('click', '.delete-media-btn .edit-media-btn', function () {
        mediaIdSelected = jQuery(this).data('id');
        rowSelected = jQuery(this).closest('tr');
    });

    jQuery(document).on('click', '.edit-media-btn', function() {
        const mediaIdSelected = jQuery(this).data('id');

        jQuery.ajax({
            url: `/media/${mediaIdSelected}`,
            method: 'GET',
            success: function(media) {
                jQuery('#add-media-modal #id').val(media.id);
                selectOptionByText(jQuery('#add-media-modal #item-type-modal-selector'), media.type);
                jQuery('#add-media-modal #title').val(media.name);
                jQuery('#add-media-modal #author').val(media.author);
                jQuery('#add-media-modal #publisher').val(media.publisher);
                jQuery('#add-media-modal #serial-number').val(media.uniqueIdentifier);
                jQuery('#add-media-modal #page-count').val(media.pageCountOrSize);
                jQuery('#add-media-modal #child-safe').prop('checked', media.isChildSafe);
                jQuery('#add-media-modal #description').val(media.description);
                jQuery('#categories-modal-selector').val(media.categories.map(x => x.id));
            }
        })
    });

    jQuery('#confirm-delete-media-btn').click(function() {
        jQuery.ajax({
            type: 'DELETE',
            url: `/media/${mediaIdSelected}`,
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
                row.append(jQuery('<td>').html(`<div class="btn-group" role="group" aria-label="Basic example"><button type="button" class="btn btn-outline-secondary" data-toggle="modal" data-target="#deleteConfirmationModal" data-id="${item.id}"><i class="fa-solid fa-circle-info"></i></button><button type="button" class="btn btn-outline-info edit-media-btn" data-toggle="modal" data-target="#add-media-modal" data-id="${item.id}"><i class="fa-solid fa-pen-to-square"></i></button><button type="button" class="btn btn-outline-danger delete-media-btn" data-toggle="modal" data-target="#delete-confirmation-modal" data-id="${item.id}"><i class="fa-solid fa-trash"></i></button></div>`));
                jQuery('#media-table tbody').append(row);
            });
        },
        error: function (xhr, status, error) {
            console.log(error?.message);
        }
    });
}
function selectOptionByText(selectElement, text) {
    jQuery(selectElement).find('option').each(function() {
        if (jQuery(this).text().toLowerCase === text.toLowerCase()) {
            jQuery(this).prop('selected', true);
            return false;
        }
    });
}