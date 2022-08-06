import 'package:flutter/material.dart';
import 'package:todolist_tomato/screens/home_screen.dart';
import 'package:todolist_tomato/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp()); // 하..
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'todolist_tomato',
      theme:  ThemeData(
        primarySwatch: Colors.red
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot)
        {
          if(snapshot.hasData){
            return const HomeScreen();
          }
          return const LoginSignupScreen();
        }
    )
    );
        }
}
