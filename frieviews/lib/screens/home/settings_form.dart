import 'package:flutter/material.dart';
import 'package:frieviews/models/theUser.dart';
import 'package:frieviews/services/database.dart';
import 'package:frieviews/shared/constants.dart';
import 'package:frieviews/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> ratings = ['1','2','3','4','5','6','7','8','9','10'];


  //formvalues
  String _currentname;
  String _currentmovietitle;
  String _currentrating;
  int _currentStrength;


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<TheUser>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {

        if(snapshot.hasData){

          UserData userData =snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Introdu datele dorite',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: userData.movietitle,
                    decoration: textInputDecoration.copyWith(hintText: 'Insert the movie title') ,
                    validator: (val) => val.isEmpty ? 'Please enter a movie title' : null,
                    onChanged: (val) => setState(() => _currentmovietitle = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration.copyWith(hintText: 'Insert your name') ,
                    validator: (val) => val.isEmpty ? 'Please enter a movie title' : null,
                    onChanged: (val) => setState(() => _currentname = val),
                  ),
                  SizedBox(height: 10.0),
                  DropdownButtonFormField(
                    value: _currentrating ?? userData.rating,
                    decoration: textInputDecoration,
                    items: ratings.map((rating){
                      return DropdownMenuItem(
                        value: rating,
                        child: Text('$rating star movie'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentrating = val ),
                  ),
                  SizedBox(height: 10.0),
  //          Slider(
  //            value: (_currentStrength ?? 100).toDouble(),
  //            activeColor: Colors.brown[_currentStrength ?? 100],
  //            inactiveColor: Colors.brown[_currentStrength ?? 100],
  //            min: 100.0,
  //            max: 900.0,
  //            divisions: 8,
  //            onChanged: (val) => setState(() => _currentStrength = val.round()),
  //          ),
  //          SizedBox(height: 10.0),
                  RaisedButton(
                    color: Colors.green[400],
                    child: Text(
                      'Update',
                      style: TextStyle(
                          color:Colors.white
                      ),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        await DatabaseService(uid: user.uid).updateUserData(_currentmovietitle ?? userData.movietitle,
                            _currentname ?? userData.name,
                            _currentrating ?? userData.rating);
                      Navigator.pop(context);

                      }
                    },
                  )
                ],
              ),
            );

        }else {

          return Loading();

        }


      }
    );
  }
}
