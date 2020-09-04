import 'package:flutter/material.dart';
import 'package:frieviews/services/auth.dart';
import 'package:frieviews/shared/constants.dart';

class Register extends StatefulWidget {

  final Function toggleview;
  Register({this.toggleview});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error = '';
  String username = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0.0,
        title: Text('Sign up to Frieviews'),
        actions: <Widget>[
          FlatButton.icon(onPressed: () {
            widget.toggleview();
          }, icon: Icon(Icons.person), label: Text('Sign in'))
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
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val){
                    setState(() {
                      email = val;
                    });

                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password') ,
                  obscureText: true,
                  validator: (val) => val.length < 6 ? 'Enter a 6+ char password' : null,
                  onChanged: (val){
                    setState(() {
                      password = val;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Username') ,
                  obscureText: true,
                  validator: (val) => val.length < 6 ? 'Enter a 6+ char username' : null,
                  onChanged: (val){
                    setState(() {
                      username = val;
                    });
                  },
                ),
                RaisedButton(
                  color: Colors.red,
                  child: Text('Register',
                    style: TextStyle(
                        color: Colors.white70),
                  ),
                  onPressed: () async {
                    if(_formkey.currentState.validate()){
                     dynamic result = await _auth.registermail(email, password, username);
                     if(result==null)
                        setState(() {
                          error='n are mail bun';
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
