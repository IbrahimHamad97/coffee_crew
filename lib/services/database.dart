import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_crew/models/brew_model.dart';
import 'package:coffee_crew/models/user_model.dart';

class DatabaseService {
  late String? uid;

  DatabaseService({this.uid});

  final CollectionReference brewCollection =
  FirebaseFirestore.instance.collection('brews');

  List <BrewModel> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return BrewModel(
          name: doc.get('name') ?? '',
          sugars: doc.get('sugars') ?? '0',
          strength: doc.get('strength') ?? 0
      );
    }).toList();
  }

  UserData _createUserData(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot['name'],
      sugars: snapshot['sugars'],
      strength: snapshot['strength'],
    );
  }

  Future updateUserData(String name, String sugars,  int strength) async {
    return await brewCollection
        .doc(uid)
        .set({ 'name': name, 'sugars': sugars, 'strength': strength});
  }

  Stream <List <BrewModel>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream <UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_createUserData);
  }
}
