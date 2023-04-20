//SHA1: EE:E1:A5:53:4C:63:D3:55:EF:67:14:71:D4:14:74:40:A8:9F:FB:E9



// POST https://fcm.googleapis.com/v1/projects/myproject-b5ae1/messages:send HTTP/1.1

// Content-Type: application/json
// Authorization: Bearer ya29.ElqKBGN2Ri_Uz...HnS_uNreA

// {
//    "message":{
//       "token":"token_1",
//       "data":{},
//       "notification":{
//         "title":"FCM Message",
//         "body":"This is an FCM notification message!",
//       }
//    }
// }
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';

class PushNotificationService{
 
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  // ignore: prefer_final_fields
  static StreamController<String> _messageStream = StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgoundHandler(RemoteMessage message )async{
    print(message.data);
    // print('onBackground Handler ${message.messageId} this is the data: ${message.data}');
    _messageStream.add(message.data['product'] ?? 'no data');

  }

  static Future _onMessageHandler(RemoteMessage message )async{
    print(message.data);
   
    // print('onMessage Handler ${message.messageId} this is the data: ${message.data}   noti : ${message.notification}');
    _messageStream.add(message.data['product'] ?? 'no data');

    
  }

  static Future _onMessageOpenApp(RemoteMessage message )async{
    print(message.data);
    
    // print('onOpen Handler ${message.messageId} this is the data: ${message.data}');
    _messageStream.add(message.data['product']?? 'no data');

   
  }

  static Future initializeApp() async{

    // Push notificaions
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print(token);

    //Handlers

    FirebaseMessaging.onBackgroundMessage(_backgoundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    //Local Notifications

  }

  static closeStreams(){
    _messageStream.close();
  }

}