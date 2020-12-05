
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frieviews/models/movie.dart';
import 'package:frieviews/screens/authenticate/register.dart';
import 'package:frieviews/screens/home/my_profile_page.dart';
import 'package:frieviews/screens/home/new_review.dart';
import 'package:frieviews/screens/home/profile_page.dart';
import 'package:frieviews/services/auth.dart';
import 'package:frieviews/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frieviews/screens/home/movie_list.dart';
import 'package:provider/provider.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:frieviews/screens/home/search_page.dart';
import 'package:frieviews/models/theUser.dart';

class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  int _currentIndex=0;

  void _onItemTapped(int index){
    setState(() {
      _currentIndex = index;
      if(_currentIndex == 0){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
      else if(_currentIndex == 1)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewReview()),
        );
    });
  }

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
          title: Text('Frieviews'),
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
//        floatingActionButton: FloatingActionButton(onPressed: ()
//        { Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => NewReview()),
//        );},
//            child: const Icon(Icons.add),
//            backgroundColor: Colors.green,
//        ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            backgroundColor: Colors.teal,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text('New Review'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search User'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile Page'),
          )
        ],
        selectedItemColor: Colors.amber[800],
        onTap: (index) async {
          switch(index){
            case 0:
              Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewReview()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyProfilePage()),
              );
            break;


    }
        },
      ),
      ),
    );
  }
}
