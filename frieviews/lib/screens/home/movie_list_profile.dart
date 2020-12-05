import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frieviews/models/movie.dart';
import 'package:provider/provider.dart';
import 'package:frieviews/screens/home/movie_tile.dart';

class MovieListProfile extends StatefulWidget {
  String currentusername;
  MovieListProfile({this.currentusername});
  @override
  _MovieListProfileState createState() => _MovieListProfileState();
}

class _MovieListProfileState extends State<MovieListProfile> {

  @override
  Widget build(BuildContext context) {

    final movies = Provider.of<List<Movie>>(context) ?? [];
//    //print(brews.documents);
//    for (var doc in movies.docs) {
//      print(doc.data());
//    }
//    movies.forEach((movie) {
//    print(movie.movietitle);
//    print(movie.name);
//    print(movie.rating);
//    });
    int i;

    for(i=0;i<movies.length;i++)
      if (movies[i].username != widget.currentusername||movies[i].movietitle=='') {
        movies.removeAt(i);
        i--;
      }
//    for(i=0;i<movies.length;i++)
//      if (movies[i].movietitle == '') {
//        movies.removeAt(i);
//      }
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieTile(movie: movies[index]);
      },

    );
  }
}