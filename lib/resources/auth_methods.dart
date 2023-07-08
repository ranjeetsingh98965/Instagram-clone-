import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
              await _firestore.collection("users").doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  // Signup user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,     // required hta diya hai
  }) async {
    String res = "Some error Occurred";
    try {
      print('signup me aya?');
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //Register User in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage("profilePics", file, false);

        model.User _user = model.User(
          username: username,
          uid: cred.user!.uid,
          photoUrl : photoUrl,
          email: email,
          bio: bio,
          followers: [],
          following: [],
        );

        //add user to our database
        await _firestore.collection("users")
            .doc(cred.user!.uid)
            .set(_user.toJson());
        res = "success";
      }
      else
        {
          res = "Please enter all the fields";
        }
    }
    catch (err) {
      return err.toString();
    }
    return res;
  }

  // Logging In User
  Future<String> loginUser({
    required String email,
    required String password
  }) async {
    String res = "Some error Occurred";
    try
    {
      if(email.isNotEmpty || password.isNotEmpty)
        {
          await _auth.signInWithEmailAndPassword(email: email, password: password);
          res = "success";
        }
      else
        {
          res = "Please enter all the fields";
        }
    }
    catch(err)
    {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
