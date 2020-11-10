import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nix_notes/core/services/auth_service.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

void main(){
  runApp(MyApp());
}


class App extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return AuthService.instance.handleAuth();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nix Notes',
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(color: Color(0xff252525),elevation: 0),
        scaffoldBackgroundColor: Color(0xff252525),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Color(0xff252525),elevation: 0),
        scaffoldBackgroundColor: Color(0xff252525),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: App(),
      ),
    );
  }
}
