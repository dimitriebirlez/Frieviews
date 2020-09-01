import 'package:cloud_firestore/cloud_firestore.dart';

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

  // get movies stream
  Stream<QuerySnapshot> get movies {
    return movieCollection.snapshots();
  }

}