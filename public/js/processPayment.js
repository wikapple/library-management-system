
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

});

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
                      <div class="col-md-12">
                        Fees? <span style="color: ${member.balance < 0 ? 'red':'green'};"> ${member.balance < 0 ? 'Yes': 'No'}</span>
                      </div>
                      </div>`;

                    let button = jQuery('<button>', {
                        html: buttonText,
                        click: function () {
                            selectMember(member);
                        },
                        class: 'btn btn-outline-info btn-block mb-2 member-select-btn',
                        disabled: member.balance < 0 ? false : true
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

    jQuery('#paying-member-form input[name="userId"]').val(member.userId);
    jQuery('#paymentForm input[name="paymentMemberId"]').val(member.userId);
    jQuery('#paying-member-form input[name="name"]').val(member.name);
    jQuery('#paying-member-form input[name="phoneNumber"]').val(member.phoneNumber);
    jQuery('#paying-member-form input[name="email"]').val(member.email);
    jQuery('#paying-member-form input[name="balance"]').val(member.balance);
    jQuery('#paying-member-form').show();
    jQuery('#paymentForm').show();
    jQuery('#member-select-modal').modal('hide');
    jQuery('#search-member-input').val('');
    updateMemberSearchResults();

}