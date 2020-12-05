import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frieviews/models/movie.dart';
import 'package:frieviews/models/theUser.dart';
import 'package:frieviews/screens/home/movie_list_profile.dart';
import 'package:frieviews/screens/home/profile_page.dart';
import 'package:frieviews/services/database.dart';
import 'package:frieviews/shared/loading.dart';
import 'package:provider/provider.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class UserResult extends StatelessWidget {

  final Movie eachUser;
  UserResult(this.eachUser);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3.0),
      child: Container(
        color: Colors.white54,
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage(currentusername: eachUser.username)),
                );
              },
              child: ListTile(
                leading: CircleAvatar(backgroundColor: Colors.black),
                title: Text(eachUser.username, style: TextStyle(
                  color: Colors.black,
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class _SearchPageState extends State<SearchPage> with AutomaticKeepAliveClientMixin<SearchPage> {


  TextEditingController searchTextEditingController = TextEditingController();
  Future<QuerySnapshot> futureSearchResults;

  emptyText(){
    searchTextEditingController.clear();
  }
  Future<List<Movie>> getusers() async {
    CollectionReference movies = FirebaseFirestore.instance.collection('movies');

    QuerySnapshot qShot = await movies.orderBy('username').get();
    return qShot.docs.map((doc) =>
         Movie(
           movietitle: doc.data()['movietitle'],
           username: doc.data()['username'],
           rating: doc.data()['rating'],
           review: doc.data()['review'],
        )).toList();
       print(qShot);
//                Future<List<UserData>> getUsers() async {
//                 QuerySnapshot qshot = await DatabaseService(uid: user.uid).movieCollection.get();
//                 return qshot.docs.map((doc) => ).toList()
//
//                }
  }
  Future<List<Movie>> getuniqueusers() async{

    int i,n,j,c;
    List<Movie> movie= await getusers();
    n=movie.length;
    for(i=0;i<n;i++){
      for(j=i+1;j<n;j++) {
        if (movie[i].username == movie[j].username) {
          for (c = j; c < n-1; c++) {
            movie[c] = movie[c + 1];
          }
          n=n-1;
          j=j-1;
        }
      }
    }
    movie.length=n;
    List finalmovie=movie;
    finalmovie.forEach((finalmovie) {
      print('${finalmovie.username}');
    });




  }
  controlSearching(String str){
    Future<QuerySnapshot> allUsers = FirebaseFirestore.instance.collection("movies").where("username", isGreaterThanOrEqualTo: str).get();
      setState(() {
        futureSearchResults = allUsers;
      });
  }
  AppBar searchPageHeader(){
    return AppBar(
      backgroundColor: Colors.teal,
      title: TextFormField(
        style: TextStyle(fontSize: 15.0,color: Colors.white),
        controller: searchTextEditingController,
        decoration: InputDecoration(
          hintText: "Search user",
          hintStyle: TextStyle(color: Colors.blueGrey),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
            filled: true,
          prefixIcon: Icon(Icons.person_pin, color: Colors.white, size: 25.0),
          suffixIcon: IconButton(icon: Icon(Icons.clear, color: Colors.white), onPressed: emptyText,)
        ),
        onFieldSubmitted: controlSearching,
      ),
    );
  }
//
  displayNoSearchResultScreen(){
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Icon(Icons.group,color: Colors.grey, size: 150.0),
            Text(
              "Search Users",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
//
  displayUsersFoundScreen(){
    return FutureBuilder(
      future: futureSearchResults,
      builder: (context, dataSnapshot){
        if(!dataSnapshot.hasData){
          return Loading();
        }

        List<UserResult> searchUsersResult = [];
        dataSnapshot.data.docs.forEach((document){
          Movie eachUser = Movie.fromDocument(document);
          UserResult userResult = UserResult(eachUser);
          searchUsersResult.add(userResult);
        });
        //return ListView(children: searchUsersResult);
        //return searchUsersResult[0];
        int i,j,n,c;
        n=searchUsersResult.length;
        for(i=0;i<n;i++){
          for(j=i+1;j<n;j++) {
            if (searchUsersResult[i].eachUser.username.toString() == searchUsersResult[j].eachUser.username.toString()) {
              for (c = j; c < n-1; c++) {
                searchUsersResult[c] = searchUsersResult[c + 1];
              }
              n=n-1;
              j=j-1;
            }
          }
        }
        searchUsersResult.length=n;
        List finalsearchUsersResult=searchUsersResult;
        finalsearchUsersResult.forEach((finalsearchUsersResult) {
          print('${finalsearchUsersResult.toString()}');
        });
        return  ListView(children: finalsearchUsersResult);
      }
    );
  }

  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {

    CollectionReference movies = FirebaseFirestore.instance.collection('movies');
    //final user = Provider.of<TheUser>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: movies.snapshots(),
      //stream: DatabaseService(uid: user.uid).userData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //UserData userData =snapshot.data;
        return Scaffold(
          appBar: searchPageHeader(),
          body: futureSearchResults == null ? displayNoSearchResultScreen() : displayUsersFoundScreen(),
//
//
//
//          FloatingActionButton(
//              onPressed: () async {
//              getuniqueusers();
//
//              }),
    );
      });
  }
}
