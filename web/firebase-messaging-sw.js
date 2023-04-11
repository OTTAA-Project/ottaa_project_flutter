importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js');

   /*Update with yours config*/
   const firebaseConfig = {
    apiKey: "AIzaSyCO20tKmBuKOlOstr5X0WHJdATfAxlfma0",
    authDomain: "ottaaproject-flutter.firebaseapp.com",
    databaseURL: "https://ottaaproject-flutter-default-rtdb.firebaseio.com",
    projectId: "ottaaproject-flutter",
    storageBucket: "ottaaproject-flutter.appspot.com",
    messagingSenderId: "873137795353",
    appId: "1:873137795353:web:40e956cef39481653d9588",
    measurementId: "G-5QCB3QD3PH",
  };

  firebase.initializeApp(firebaseConfig);
  const messaging = firebase.messaging();

  /*messaging.onMessage((payload) => {
  console.log('Message received. ', payload);*/
  messaging.onBackgroundMessage(function(payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
      body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
      notificationOptions);
  });