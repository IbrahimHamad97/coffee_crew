import 'package:coffee_crew/models/user_model.dart';
import 'package:coffee_crew/services/database.dart';
import 'package:coffee_crew/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:coffee_crew/shared/shared.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List sugars = ['0', '1', '2', '3', '4'];

  String? _name;
  String? _sugar;
  int? _strength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData){
          UserData? userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Update your brew",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFormField(
                  initialValue: userData!.name,
                  onChanged: (val) {
                    setState(() {
                      _name = val;
                    });
                  },
                  decoration: textInputDecoration.copyWith(labelText: "Update Name"),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  value: userData.sugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                        value: sugar, child: Text('$sugar Sugars'));
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _sugar = val.toString();
                    });
                  },
                ),
                SizedBox(height: 20),
                Slider(
                    min: 100,
                    max: 900,
                    divisions: 8,
                    activeColor: Colors.yellow[(_strength ?? 100)],
                    inactiveColor: Colors.yellow[(_strength ?? 100)],
                    value: (_strength ?? 100).toDouble(),
                    onChanged: (val) {
                      setState(() {
                        _strength = val.round();
                      });
                    }),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()){
                          await DatabaseService(uid: user.uid).updateUserData(
                            _name ?? userData.name!,
                            _sugar ?? userData.sugars!,
                            _strength ?? userData.strength!,
                          );
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pink[100],
                      ),
                      child: Text("Go to Login Page")),
                ),
              ],
            ),
          );
        }
        else {
          return Loading();
        }

      }
    );
  }
}
