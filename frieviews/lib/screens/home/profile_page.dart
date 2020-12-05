import 'package:flutter/material.dart';
import 'package:frieviews/models/movie.dart';
import 'package:frieviews/models/theUser.dart';
import 'package:frieviews/screens/home/new_review.dart';
import 'package:frieviews/services/auth.dart';
import 'package:frieviews/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frieviews/screens/home/movie_list.dart';
import 'package:provider/provider.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:frieviews/screens/home/search_page.dart';
import 'package:frieviews/screens/home/movie_list_profile.dart';

class ProfilePage extends StatefulWidget {
  String currentusername;
  ProfilePage({this.currentusername});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {


    return StreamProvider<List<Movie>>.value(
      value: DatabaseService().movies,
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          title: Text('Frieviews'),
          backgroundColor: Colors.teal,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(onPressed: () async {
              //await _auth.signOut();
            }, icon: Icon(Icons.person),
                label: Text('logout')),

          ],
        ),
        body: MovieListProfile(currentusername: widget.currentusername,),
      ),
    );
  }
}
