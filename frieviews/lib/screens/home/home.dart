
import 'package:frieviews/models/movie.dart';
import 'package:frieviews/screens/home/new_review.dart';
import 'package:frieviews/services/auth.dart';
import 'package:frieviews/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frieviews/screens/home/movie_list.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

//    void _showSettingsPanel() {
//      showModalBottomSheet(context: context, builder: (context){
//        return Container(
//          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
//          child: SettingsForm(),
//        );
//      });
//    }

    return StreamProvider<List<Movie>>.value(
      value: DatabaseService().movies,
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          title: Text('Friviews'),
          backgroundColor: Colors.teal,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(onPressed: () async {
              await _auth.signOut();
            }, icon: Icon(Icons.person),
                label: Text('logout')),

          ],
        ),
        body: MovieList(),
        floatingActionButton: FloatingActionButton(onPressed: ()
        { Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewReview()),
        );},
            child: const Icon(Icons.add),
            backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
