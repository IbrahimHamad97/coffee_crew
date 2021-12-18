import 'package:coffee_crew/models/brew_model.dart';
import 'package:coffee_crew/models/user_model.dart';
import 'package:coffee_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _makeUser(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }


  Stream<UserModel?> get user {
    return _auth.authStateChanges().map((User? user) => _makeUser(user!));
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _makeUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future regWithEmailPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user!.uid).updateUserData("Brho", "3",  7);
      return _makeUser(user);
    }
    catch (e){
      print(e.toString());
      return null;
    }
  }

  Future logInEmailPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _makeUser(user!);
    }
    catch (e){
      print(e.toString());
      return null;
    }
  }

  Future logOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
