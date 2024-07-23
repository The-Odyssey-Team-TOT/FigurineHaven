document.addEventListener("DOMContentLoaded", function() {
  console.log("Checkout script loaded");
  var stripe = Stripe('pk_test_51PfKYUEweLYElQZZDtmrNbhX9HG9L0biivTabMdWY3pwXjaIFGpq5Uln3cbfQb875DlXJj5f8YPtNCoGMnYz5nrB003MMfzQL4');
  var checkoutButton = document.getElementById('checkout-button');

  checkoutButton.addEventListener('click', function () {
    fetch('/checkout/create', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
    })
    .then(function (response) {
      return response.json();
    })
    .then(function (data) {
      console.log("Session ID:", data.sessionId); // Log pour vérifier la session ID
      return stripe.redirectToCheckout({ sessionId: data.sessionId });
    })
    .then(function (result) {
      if (result.error) {
        alert(result.error.message);
      }
    })
    .catch(function (error) {
      console.error('Error:', error);
    });
  });
});
