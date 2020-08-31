import 'package:flutter/material.dart';
import 'package:frieviews/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SignIn extends StatefulWidget {

  final Function toggleview;
  SignIn({this.toggleview});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0.0,
        title: Text('Sign in to Frieviews'),
        actions: <Widget>[
          FlatButton.icon(onPressed:() {
            widget.toggleview();
          }, icon: Icon(Icons.person), label: Text('Register'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formkey,

          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });

                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a 6+ char password' : null,
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 10.0),
              RaisedButton(
                color: Colors.red,
                child: Text('Sign in',
                style: TextStyle(
                  color: Colors.white70),
                ),
              onPressed: () async {
                if(_formkey.currentState.validate()){
                  dynamic result = await _auth.signinmail(email, password);
                  if(result==null)
                    setState(() {
                      error='nu se poate loga';
                    });
                }
              },
              ),
              SizedBox(height: 10.0),
              Text(error,
                  style: TextStyle(color: Colors.red, fontSize: 10.0)),
              ],
          ),
        )
      ),
    );
  }
}
