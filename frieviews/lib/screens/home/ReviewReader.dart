import 'package:flutter/material.dart';
import 'new_review.dart';
import 'package:frieviews/screens/home/movie_tile.dart';
import 'package:frieviews/models/movie.dart';

class ReviewReader extends StatelessWidget {

  final Movie movie;
  ReviewReader({this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review of ${movie.movietitle}'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              '${movie.rating}/10',
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              '${movie.review}'
            )
          ],
        ),
      ),
      backgroundColor: Colors.blueGrey[200],
    );
  }
}
