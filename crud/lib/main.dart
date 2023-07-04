

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'Screens/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(  MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _initialization,
      builder: ( context, snapshot) {
        if(snapshot.hasError){
          if (kDebugMode) {
            print("Kuch toh galt hai Bete");
          }
        }
        if(snapshot.connectionState == ConnectionState.done){
         return MaterialApp(
           debugShowCheckedModeBanner: false,
            theme: ThemeData(

scaffoldBackgroundColor: Colors.purpleAccent,
              primarySwatch: Colors.purple,
            ),
            home:const Home(),
          );
        }
        return const Center(child: CircularProgressIndicator());
        },

    );
  }
}


