import 'package:flutter/material.dart';
import 'package:notifications/screens/screens.dart';
import 'package:notifications/services/services.dart';

void main() async{
  // Si hay algun error colocar el sigueinte codigo
  WidgetsFlutterBinding.ensureInitialized();
  PushNotificationService.initializeApp();
  runApp(const MyApp());

}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

    //context
    PushNotificationService.messagesStream.listen((message) { 
      print('MyApp:$message');

      final snackBar = SnackBar(content: Text(message));


      messengerKey.currentState?.showSnackBar(snackBar);
      navigatorKey.currentState?.pushNamed('message',arguments: message);

    });
  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      navigatorKey: navigatorKey ,// navegar
      scaffoldMessengerKey: messengerKey,//Snaks
      routes: {
        'home'    : (_) => const HomeScreen(),
        'message' : (_) => const MessageScreen(),
      }
      ,
    );
  }
}