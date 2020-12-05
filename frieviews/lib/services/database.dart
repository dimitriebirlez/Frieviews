import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frieviews/models/movie.dart';
import 'package:frieviews/models/theUser.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference movieCollection = FirebaseFirestore.instance.collection('movies');

  Future<void> updateUserData(String movietitle, String username,String review, String rating) async {
    return await movieCollection.doc(uid).set({
      'movietitle': movietitle,
      'username': username,
      'review': review,
      'rating': rating,
    });
  }

  //lista filme din snapshot

  List<Movie> _movieListfromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Movie(
        movietitle: doc.data()['movietitle'] ?? '',
        username: doc.data()['username'] ?? '',
        review: doc.data()['review'] ?? '',
        rating: doc.data()['rating'] ?? ''
      );
    }).toList();
  }
  //userData from snapshot
  UserData _userdatafromsnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      movietitle: snapshot.data()['movietitle'],
      username: snapshot.data()['username'],
      review: snapshot.data()['review'],
      rating: snapshot.data()['rating']
    );
  }
  // get movies stream
  Stream<List<Movie>> get movies {
    return movieCollection.snapshots()
    .map(_movieListfromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return movieCollection.doc(uid).snapshots()
    .map(_userdatafromsnapshot);
  }
}