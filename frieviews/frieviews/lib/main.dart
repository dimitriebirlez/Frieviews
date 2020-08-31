import 'package:flutter/material.dart';
import 'package:frieviews/models/theUser.dart';
import 'package:frieviews/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frieviews/services/auth.dart';
import 'package:provider/provider.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<TheUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

