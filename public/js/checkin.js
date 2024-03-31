
jQuery(document).ready(function () {

    jQuery('#search-item-btn').click(function () {
        const searchValue = jQuery('#search-item-input').val();
        updateItemSearchResults(searchValue);
    });

    jQuery('#search-item-input').keypress(function (event) {
        if (event.which === 13) {
            const searchValue = jQuery('#search-item-input').val();
            updateItemSearchResults(searchValue);
        }

    });

    jQuery('#clear-item-search-btn').click(function () {
        jQuery('#search-item-input').val('');
        updateItemSearchResults();
    });

    jQuery('#item-select-modal').on('shown.bs.modal', function () {
        initializeScanner();

    });
    jQuery('#item-select-modal').on('hidden.bs.modal', function () {
        jQuery('#search-item-input').val('');
        updateItemSearchResults();
    });

    jQuery('#item-table').on('click', '.remove-item-btn', function() {
        jQuery(this).closest('tr').remove();
    })

});

async function initializeScanner() {
    jQuery('#qrcode-spinner').show();
    let cameras = await Html5Qrcode.getCameras();
    let camera = cameras[0];

    const scanner = new Html5Qrcode('rentalItemQrcodeReader');
    scanner.start(
        camera.id,
        {
            fps: 10,
            qrbox: { width: 250, height: 250 }
        },
        (decodedText, decodedResult) => {
            // action on success
            processRentalItemId(decodedText);
            scanner.stop().then((ignore) => {
                // What to do when scanner stops
              }).catch((err) => {
                // What to do when scanner stopping causes an error
              });

        },
        (errorMessage) => {
            // error 
            //console.log(errorMessage);
        })
        .catch((err) => {
            console.log(err);
        }).then(() => {
            jQuery('#qrcode-spinner').hide();
        });
        

}

function updateItemSearchResults(filter = undefined) {
    const resultsContainer = jQuery('#item-search-results');

    if (!filter) {
        resultsContainer.html(`<div class="text-center">None</div>`);
    }
    else {
        jQuery.ajax({
            url: `/api/item?filter=${filter}&checkedOut=true`,
            method: 'GET',
            success: function (response) {
                resultsContainer.empty();

                if (response.length >= 10) {
                    resultsContainer.html(`<p class="lead">Please refine your search. Search returned 10 or more results</p>`);
                    return;
                }
                if (response.length == 0) {
                    resultsContainer.html(`<div class="text-center">No matchings rental items found.</div>`);
                    return;
                }

                jQuery.each(response, function (index, rentalItem) {
                    buttonText = `<div class="row">
                    <div class="col-12 mb-1">
                         Id: <strong>${rentalItem.rentalItemGuid}</strong>
                    </div>
                    <div class="col-md-12" mb-1>
                    name: <strong>${rentalItem.name}</strong>
                    </div>
                    </div>
                    <div class="row">
                    <div class="col-md-12 mb-1">
                     item type: <strong>${rentalItem.itemType}</strong> 
                     </div>
                      </div>`;

                    let button = jQuery('<button>', {
                        html: buttonText,
                        click: function () {
                            selectItem(rentalItem);
                        },
                        class: 'btn btn-outline-info btn-block mb-2 item-select-btn'
                    });

                    resultsContainer.append(button);
                })
            },
            error: function (xhr, status, error) {
                console.log(error?.message);
            }
        });
    }
}

function selectCheckinItem(rentalItem, rentalAgreement) {

    jQuery('#item-select-modal').modal('hide');
    jQuery('#search-item-input').val('');
}

async function processRentalItemId(rentalItemId) {
    const rentalItem = await getRentalItem(rentalItemId);
    let rentalAgreement;
    if (rentalItem) {
        rentalAgreement = await getActiveRentalAgreement(rentalItemId);
    }

    if (rentalItem && rentalAgreement) {
        selectCheckinItem(rentalItem, rentalAgreement);
    } else {
        console.log("Error retrieving rental item or rental agreement");
    }
}

async function getRentalItem(rentalItemId) {
    jQuery.ajax({
        url: `/api/item/${rentalItemId}`,
        method: 'GET',
        success: function (response) {
            if (response) {
                return(response);
                
            } else {
                // What to do if no valid rental item is returned?

            }
        },
        error: function (error) {
            initializeScanner();
            // What to do on an api error
        }
    });
}

async function getRentalAgreementsByRentalItemId(rentalItemId) {
    jQuery.ajax({
        url: `/api/rentalAgreement/byRentalItem/${rentalItemId}?isActive=true`,
        method: 'GET',
        success: function (response) {
            if (response) {
                return(response);
                
            } else {
                // What to do if no valid rental item is returned?

            }
        },
        error: function (error) {
            initializeScanner();
            // What to do on an api error
        }
    });
}