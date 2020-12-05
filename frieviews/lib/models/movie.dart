import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String movietitle;
  final String username;
  final String review;
  final String rating;

  Movie({this.movietitle,this.username, this.review, this.rating});


  factory Movie.fromDocument(DocumentSnapshot doc){
    return Movie(
        movietitle: doc.data()['movietitle'],
        username: doc.data()['username'],
        review: doc.data()['review'],
        rating: doc.data()['rating']
    );
  }

}