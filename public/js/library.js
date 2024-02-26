
jQuery(document).ready(function() {
    jQuery('#registerForm').submit(function(event) {
        event.preventDefault();

        var password = jQuery('#password').val();
        var confirmPassword = jQuery('#passwordConfirmation').val();

        if(password !== confirmPassword) {
            jQuery('#error').show();
        } else {
            jQuery('#error').hide();
            jQuery(this).unbind('submit').submit();
        }
    })
});

const logout = () => {
    fetch('auth/logout', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
    }).then(response => {
        if (response.redirected) {
            window.location.href = response.url;
        } else {
            console.log('Logout success');
        }
    })
    .catch(error => {
        console.log('Error:',error);
    })
}