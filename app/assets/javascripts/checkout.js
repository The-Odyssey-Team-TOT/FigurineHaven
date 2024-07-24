// document.addEventListener('DOMContentLoaded', function() {
//   // Sélectionner le bouton de checkout par son ID
//   var checkoutButton = document.getElementById('checkout-button');

//   // Vérifier que le bouton est présent sur la page
//   if (checkoutButton) {
//     // Ajouter un écouteur d'événement pour le clic sur le bouton
//     checkoutButton.addEventListener('click', function() {
//       // Envoi d'une requête POST à l'endpoint '/checkout/create'
//       fetch('/checkout/create', {
//         method: 'POST',
//         headers: {
//           'Content-Type': 'application/json',
//           'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
//         }
//       })
//       .then(response => response.json()) // Analyser la réponse JSON
//       .then(data => {
//         console.log("Response Data:", data); // Log des données pour le débogage

//         // Vérifier la présence d'une erreur dans les données reçues
//         if (data.error) {
//           alert(data.error); // Afficher l'erreur à l'utilisateur
//         } else {
//           // Rediriger vers Stripe avec l'ID de session reçu
//           var stripe = Stripe('pk_test_YOUR_PUBLIC_STRIPE_KEY'); // Remplacez par votre clé publique Stripe
//           stripe.redirectToCheckout({ sessionId: data.sessionId })
//           .then(function (result) {
//             // Si une erreur se produit lors de la redirection
//             if (result.error) {
//               alert(result.error.message); // Afficher le message d'erreur
//             }
//           });
//         }
//       })
//       .catch(error => {
//         console.error('Error:', error); // Log des erreurs dans la console
//       });
//     });
//   }
// });
