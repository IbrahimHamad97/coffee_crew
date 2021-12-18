import 'package:coffee_crew/models/brew_model.dart';
import 'package:coffee_crew/screens/brews_list.dart';
import 'package:coffee_crew/services/auth.dart';
import 'package:coffee_crew/services/database.dart';
import 'package:coffee_crew/widgets/settings_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    void _showUpdatePage() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List <BrewModel>?>.value(
      value: DatabaseService().brews,
      initialData: null,
      catchError: (_, __) => null,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await _auth.logOut();
              }),
          actions: [
            IconButton(icon: Icon(Icons.account_circle), onPressed: () => _showUpdatePage(),
            )
          ],
          backgroundColor: Colors.yellow[200],
        ),
        body: BrewList(),
      ),
    );
  }
}
