import 'package:coffee_crew/models/user_model.dart';
import 'package:coffee_crew/screens/home_screen.dart';
import 'package:coffee_crew/screens/login_screen.dart';
import 'package:coffee_crew/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool isSignIn = true;

  void changePage() {
    setState(() => isSignIn = !isSignIn);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    if (user == null) {
      return Scaffold(
          body: isSignIn
              ? LogInScreen(changePage: changePage)
              : SignUpScreen(changePage: changePage));
    } else {
      return Scaffold(body: HomeScreen());
    }
  }
}
