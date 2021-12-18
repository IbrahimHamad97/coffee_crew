import 'package:coffee_crew/models/brew_model.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {
  final BrewModel brew;

  BrewTile({required this.brew});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.yellow[brew.strength!],
          ),
          title: Text(brew.name!),
          subtitle: Text("Takes ${brew.sugars!} sugar(s)"),
        ),
      ),
    );
  }
}
