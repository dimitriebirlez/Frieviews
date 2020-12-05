import 'package:flutter/material.dart';
import 'package:frieviews/models/movie.dart';
import 'package:frieviews/models/theUser.dart';
import 'package:frieviews/screens/home/movie_list_profile.dart';
import 'package:frieviews/services/database.dart';
import 'package:frieviews/shared/constants.dart';
import 'package:frieviews/shared/loading.dart';
import 'package:provider/provider.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePage createState() => _MyProfilePage();
}

class _MyProfilePage extends State<MyProfilePage> {


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<TheUser>(context);

    return StreamProvider<List<Movie>>.value(
    value: DatabaseService().movies,
      child: StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {

            if(snapshot.hasData){

              UserData userData =snapshot.data;
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.teal,
                  title: Text('My Profile'),
                ),
                body: MovieListProfile(currentusername: userData.username.toString(),)
              );

            }else {

              return Loading();

            }


          }
      ),
    );
  }
}