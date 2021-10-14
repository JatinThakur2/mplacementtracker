import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mplacementtracker/constants.dart';
import 'package:mplacementtracker/model/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'UI/splash_screen.dart';

void main() => runApp(new MyApp());
class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}


class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  static late User? currentUser;

  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;


  Color _primaryColor = HexColor('#DC54FE');
  Color _accentColor = HexColor('#8A02AE');
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }
  
  @override
   Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return MaterialApp(
          home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
              child: Column(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 25,
              ),
              SizedBox(height: 16),
              Text(
                'Failed to initialise firebase!',
                style: TextStyle(color: Colors.red, fontSize: 25),
              ),
            ],
          )),
        ),
      ));
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }

    return MaterialApp(
        theme: ThemeData(accentColor: Color(COLOR_PRIMARY)),
        debugShowCheckedModeBanner: false,
        color: Color(COLOR_PRIMARY),
        home: SplashScreen(title: '',));
  }

  @override
  void initState() {
    super.initState();
    initializeFlutterFire();
  }
}



