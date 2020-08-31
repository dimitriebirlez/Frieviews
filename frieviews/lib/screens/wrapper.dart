import 'package:flutter/material.dart';
import 'package:frieviews/models/theUser.dart';
import 'package:frieviews/screens/authenticate/authenticate.dart';
import 'package:frieviews/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<TheUser>(context);
    print(user);

    //intra in home sau autheticate
    if(user == null)
      {
        return Authenticate();
      }
    else{
      return Home();
    }
  }
}
