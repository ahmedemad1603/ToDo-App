import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/firebase/firestore_helper.dart';
import 'package:todo_app/model/user.dart' as MyUser;

class AuthUserProvider extends ChangeNotifier
{
  User? firebaseUser;
  MyUser.User? databaseUser;

  setUser(User newFirebaseUser, MyUser.User newDatabaseUser)
  {
    firebaseUser = newFirebaseUser;
    databaseUser = newDatabaseUser;
    notifyListeners();
  }

  Future<void> retrieveUser() async
  {
    firebaseUser = FirebaseAuth.instance.currentUser;
    databaseUser = await FirestoreHelper.getUser(firebaseUser?.uid??"");
  }
}