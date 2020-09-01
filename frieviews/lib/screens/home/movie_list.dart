import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {

    final movies = Provider.of<QuerySnapshot>(context);
    //print(brews.documents);
    for (var doc in movies.docs) {
      print(doc.data());
    }

    return Container(

    );
  }
}