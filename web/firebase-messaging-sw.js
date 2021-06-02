importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-messaging.js");

var firebaseConfig = {
    apiKey: "AIzaSyAMiBfzs9bA_EF3-Sdy8AGEBhb5urqJlBM",
    authDomain: "challengespwa.firebaseapp.com",
    projectId: "challengespwa",
    storageBucket: "challengespwa.appspot.com",
    messagingSenderId: "863363907686",
    appId: "1:863363907686:web:e9a4cf3e51abb99b472da7",
    measurementId: "G-5R54CNX61Q",
  };

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

//messaging.usePublicVapidKey('BKS1ajSLsuJknuMLwO3wnarsA2nUxQnZZCi9ERkuhCWVZEcGZhdQobqbYHrSX7UFzQUPxoipSlTExsCGNE2HNT4');


messaging.onBackgroundMessage((payload) => {
    console.log('[firebase-messaging-sw.js] Received background message ', payload);
    // Customize notification here
    const notificationTitle = 'Background Message Title';
    const notificationOptions = {
      body: 'Background Message body.',
      icon: '/firebase-logo.png'
    };
  
    self.registration.showNotification(notificationTitle,
      notificationOptions);
  });