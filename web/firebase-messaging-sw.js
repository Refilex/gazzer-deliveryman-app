importScripts("https://www.gstatic.com/firebasejs/7.20.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.20.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyCfxGdnL_KhgbNDY7mFQh-tHHBqIaxisYw",
  projectId: "gazzer-app",
  messagingSenderId: "671839887516",
  appId: "1:671839887516:android:943c43dfaadfac33798d59",
  databaseURL: "...",
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});