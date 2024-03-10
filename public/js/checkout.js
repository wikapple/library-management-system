
jQuery(document).ready(function () {
    updateMemberSearchResults();
    jQuery('#search-member-btn').click(function () {
        const searchValue = jQuery('#search-member-input').val();
        updateMemberSearchResults(searchValue);
    });

    jQuery('#search-member-input').keypress(function (event) {
        if (event.which === 13) {
            const searchValue = jQuery('#search-member-input').val();
            updateMemberSearchResults(searchValue);
        }

    });

    jQuery('#clear-member-search-btn').click(function () {
        jQuery('#search-member-input').val('');
        updateMemberSearchResults();
    });

    updateItemSearchResults();

    jQuery('#select-item-modal').on('shown.bs.modal', function () {
        scanQrCode();
    });

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

});

async function initializeScanner() {

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
        });

}

function updateMemberSearchResults(filter = undefined) {
    const resultsContainer = jQuery('#member-search-results');

    if (!filter) {
        resultsContainer.html(`<div class="text-center">None</div>`);
    }
    else {
        jQuery.ajax({
            url: `/api/member?filter=${filter}`,
            method: 'GET',
            success: function (response) {
                resultsContainer.empty();

                if (response.length >= 10) {
                    resultsContainer.html(`<p class="lead">Please refine your search. Search returned 10 or more results</p>`);
                }
                if (response.length == 0) {
                    resultsContainer.html(`<div class="text-center">No matchings members found.</div>`);
                }

                jQuery.each(response, function (index, member) {
                    buttonText = `<div class="row">
                    <div class="col-12 mb-1">
                         Id: <strong>${member.userId}</strong>
                    </div>
                    <div class="col-md-12" mb-1>
                    name: <strong>${member.name}</strong>
                    </div>
                    </div>
                    <div class="row">
                    <div class="col-md-12 mb-1">
                     email: <strong>${member.email}</strong> 
                     </div>
                     <div class="col-md-12">
                      phone-number: <strong>${member.phoneNumber}</strong>
                      </div>
                      </div>`;

                    let button = jQuery('<button>', {
                        html: buttonText,
                        click: function () {
                            selectMember(member);
                        },
                        class: 'btn btn-outline-info btn-block mb-2 member-select-btn'
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

function selectMember(member) {

    jQuery('#checkout-member-form input[name="userId"]').val(member.userId);
    jQuery('#checkout-member-form input[name="name"]').val(member.name);
    jQuery('#checkout-member-form input[name="phoneNumber"]').val(member.phoneNumber);
    jQuery('#checkout-member-form input[name="email"]').val(member.email);
    jQuery('#checkout-member-form').show();
    jQuery('#member-select-modal').modal('hide');
    jQuery('#search-member-input').val('');
    updateSearchResults();

}

function updateItemSearchResults(filter = undefined) {
    const resultsContainer = jQuery('#item-search-results');

    if (!filter) {
        resultsContainer.html(`<div class="text-center">None</div>`);
    }
    else {
        jQuery.ajax({
            url: `/api/item?filter=${filter}`,
            method: 'GET',
            success: function (response) {
                resultsContainer.empty();

                if (response.length >= 10) {
                    resultsContainer.html(`<p class="lead">Please refine your search. Search returned 10 or more results</p>`);
                }
                if (response.length == 0) {
                    resultsContainer.html(`<div class="text-center">No matchings rental items found.</div>`);
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

function selectItem(rentalItem) {

    const currentDate = new Date().toISOString().split('T')[0];
    let twoWeeksFromToday = new Date();
    twoWeeksFromToday.setDate(twoWeeksFromToday.getDate() + 14);
    twoWeeksFromToday = twoWeeksFromToday.toISOString().split('T')[0];

    var currentDateInputField = $('<input>', {
        id: 'checkoutDateInput',
        type: 'date',
        class: 'form-control',
        value: currentDate,
        disabled: true
    });
    var twoWeeksLaterInputField = $('<input>', {
        id: 'twoWeeksLaterInput',
        type: 'date',
        class: 'form-control',
        value: twoWeeksFromToday,
        disabled: false,
        min: currentDate
    });
    let row = jQuery('<tr>');
    row.append(jQuery('<td>').text(rentalItem.rentalItemGuid));
    row.append(jQuery('<td>').text(rentalItem.name));
    row.append(jQuery('<td>').text(rentalItem.itemType));
    row.append(jQuery('<td>').append(currentDateInputField));
    row.append(jQuery('<td>').append(twoWeeksLaterInputField));
    row.append(jQuery('<td>').html(`<button class="btn btn-outline-danger" onClick="">Remove Item</button>`));
    jQuery('#item-table tbody').append(row);

    jQuery('#item-select-modal').modal('hide');
    jQuery('#search-item-input').val('');
}

async function processRentalItemId(rentalItemId) {
    jQuery.ajax({
        url: `/api/item/${rentalItemId}`,
        method: 'GET',
        success: function (response) {
            if (response) {
                selectItem(response);
                
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