import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frieviews/models/theUser.dart';
import 'package:frieviews/services/database.dart';

class AuthService {

  //FirebaseApp a = await Firebase.initializeApp();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //creeaza theuser obiect bazat pe firebase

  TheUser _userFromFirebaseUser(User user) {
    return user !=null ? TheUser(uid: user.uid) : null;
  }

  //auth change user stream

  Stream<TheUser> get user {

    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }

  //sign in anon
  Future signInAnon() async {

    try{
      UserCredential userCredential = await _auth.signInAnonymously();
      User user = userCredential.user;
     return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sig in mail

  Future signinmail(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register mail
  Future registermail(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      //se creeaza document nou pt fiecare user
      await DatabaseService(uid: user.uid).updateUserData('What is the name of the movie?','name', '1');

      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out

  Future signOut() async {

    try {
      return await _auth.signOut();

  }catch(e){
      print(e.toString());
      return null;
  }
}

}
