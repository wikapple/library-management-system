jQuery(document).ready(function () {
    initializeMediaTypes();
    initializeMediaList();
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
            select.find('option').eq(0).prop('selected', true);
        },
        error: function (xhr, status, error) {
            console.error('Error fetching data:', error);
        }
    });
}

function initializeMediaList(){

}