import 'dart:async';
import 'package:frieviews/screens/authenticate/register.dart';
import 'package:flutter/material.dart';
import 'package:frieviews/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleview(){
    setState(() {
      showSignIn =! showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn)
      return SignIn(toggleview: toggleview);
    else
      return Register(toggleview: toggleview);
  }
}
