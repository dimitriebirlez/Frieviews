import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:frieviews/models/movie.dart';

class MovieTile extends StatelessWidget {

  final Movie movie;
  MovieTile({this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 4.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            child: Text('${movie.rating}/10',
            style: TextStyle(
              color: Colors.white
            ),
            ),
            backgroundColor: Colors.green[800],
          ),
          title: Text(movie.movietitle),
          subtitle: Text('by ${movie.name}'),
        ),
      ),
    );
  }
}
