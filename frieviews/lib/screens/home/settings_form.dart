import 'package:flutter/material.dart';
import 'package:frieviews/shared/constants.dart';

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


  @override
  Widget build(BuildContext context) {
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
            decoration: textInputDecoration.copyWith(hintText: 'Insert the movie title') ,
            validator: (val) => val.isEmpty ? 'Please enter a movie title' : null,
            onChanged: (val) => setState(() => _currentmovietitle = val),
          ),
        SizedBox(height: 10.0),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: 'Insert your name') ,
            validator: (val) => val.isEmpty ? 'Please enter a movie title' : null,
            onChanged: (val) => setState(() => _currentname = val),
          ),
          SizedBox(height: 10.0),
          DropdownButtonFormField(
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
          RaisedButton(
            color: Colors.green[400],
            child: Text(
              'Update',
              style: TextStyle(
                color:Colors.white
              ),
            ),
            onPressed: () async {
              print(_currentmovietitle);
              print(_currentname);
              print(_currentrating);
            },
          )
        ],
      ),
    );
  }
}
