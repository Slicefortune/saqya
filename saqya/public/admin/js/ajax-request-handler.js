'use strict';

const BUTTON_LOADER = `<span class="spinner-border me-1" role="status" aria-hidden="true"></span>Loading...`

function sendRequest(route, method, formData, eventTarget) {
    eventTarget?.find('button[type="submit"]').html(BUTTON_LOADER).attr('disabled', true)
    return new Promise(function (resolve, reject) {
        $.ajax({
            url: route,
            method: method,
            data: formData,
            processData: false,
            contentType: false,
            headers: {
                Accept: 'application/json'
            },
            success: function (data) {
                eventTarget?.find('button[type="submit"]').html("Submit").attr('disabled', false)
                resolve(data);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                eventTarget?.find('button[type="submit"]').html('Submit').attr('disabled', false)
                const errors = jqXHR.responseJSON?.errors;
                if (errors && errors.length) {
                    for (let key in errors) {
                        showToast(errors[key], 'error');
                    }
                } else {
                    showToast(errorThrown, 'error')
                }
                reject(errorThrown);
            }
        });
    });
}

// Function to show a toast with the given message
function showToast(message, type = 'success') {
    var toastElement = document.createElement('div');
    toastElement.classList.add('toast');
    toastElement.classList.add('show');
    toastElement.setAttribute('role', 'alert');
    toastElement.setAttribute('aria-live', 'assertive');
    toastElement.setAttribute('aria-atomic', 'true');

    var toastBody = document.createElement('div');
    toastBody.classList.add('toast-body');
    toastBody.textContent = message;

    toastElement.appendChild(toastBody);

    // Add custom class based on the type of toast
    if (type === 'error') {
        toastElement.classList.add('bg-danger', 'text-white'); // Red background for error
    } else if (type === 'success') {
        toastElement.classList.add('bg-success', 'text-white'); // Green background for success
    }

    document.getElementById('myToastContainer').appendChild(toastElement);

    var toast = new bootstrap.Toast(toastElement);
    toast.show();
}
