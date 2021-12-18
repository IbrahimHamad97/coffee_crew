import 'package:coffee_crew/services/auth.dart';
import 'package:coffee_crew/shared/loading.dart';
import 'package:coffee_crew/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LogInScreen extends StatefulWidget {
  late Function changePage;

  LogInScreen({required this.changePage});

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        width: double.maxFinite,
        height: double.maxFinite,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Log in here"),
              SizedBox(height: 20),
              TextFormField(
                validator: (val) => val!.isEmpty ? "Enter An Email" : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
                decoration: textInputDecoration.copyWith(labelText: "Email"),
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                validator: (val) =>
                    val!.length < 6 ? "Need a longer Password" : null,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                decoration: textInputDecoration.copyWith(labelText: "Password"),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        Fluttertoast.showToast(msg: "Logged in");
                        dynamic result =
                            await _auth.logInEmailPassword(email, password);
                        if (result == null) {
                          setState(() {
                            loading = true;
                          });
                          Fluttertoast.showToast(msg: "Error");
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "Fields are empty",
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.yellow[300],
                    ),
                    child: Text("log in")),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      widget.changePage();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink[100],
                    ),
                    child: Text("Go to SignUp page")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
