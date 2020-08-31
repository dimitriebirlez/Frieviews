import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frieviews/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text('Friviews'),
        backgroundColor: Colors.teal,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(onPressed: () async {
            await _auth.signOut();
          }, icon: Icon(Icons.person), label: Text('logout'))
        ],
      ),
    );
  }
}
