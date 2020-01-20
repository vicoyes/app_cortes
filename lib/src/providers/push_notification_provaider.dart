

import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';




class PushNotification {


  final _mensaje = StreamController.broadcast();

  Stream get mensaje => _mensaje.stream;

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  initNotification(){
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token){

      print('======token========');
      print(token);

      //e4X2oGIR_Lg:APA91bHOziutiue4KauEEBWl7T9RP89vJWLNEXWKyMMCK822c0Gvi6Q8jS9ItBfqHg7fRKZIAWDVDP8F-VJd_U392NY0r39rLFYRovcJVw5uyft1JWhIjCTGVaAJkgI4KYgmULnQEOdD
      
    });

    _firebaseMessaging.configure(
      
      onMessage: (info) async{
        
        print('=====onMessage=====');
        print(info);

        var argumento;

         if(Platform.isAndroid){
            argumento = info['notification']['body'] ?? 'no-data';
         }
        _mensaje.sink.add(argumento);
      },

      onLaunch: (info) async{
        
        print('=====onLaunch=====');
        print(info);
      },

      onResume:  (info) async{
        
        print('=====onResume=====');
        print(info);
      },

    );
  }

dispose(){
  _mensaje?.close();
}
  
}