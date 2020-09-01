import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frieviews/models/movie.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference movieCollection = FirebaseFirestore.instance.collection('movies');

  Future<void> updateUserData(String movietitle, String name, int rating) async {
    return await movieCollection.doc(uid).set({
      'movietitle': movietitle,
      'name': name,
      'rating': rating,
    });
  }

  //lista filme din snapshot

  List<Movie> _movieListfromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Movie(
        movietitle: doc.data()['movietitle'] ?? '',
        name: doc.data()['name'] ?? '',
        rating: doc.data()['rating'] ?? 0
      );
    }).toList();
  }

  // get movies stream
  Stream<List<Movie>> get movies {
    return movieCollection.snapshots()
    .map(_movieListfromSnapshot);
  }

}