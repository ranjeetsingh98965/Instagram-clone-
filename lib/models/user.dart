
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  const User({
      required this.email,
      required this.uid,
      required this.photoUrl,
      required this.username,
      required this.bio,
      required this.followers,
      required this.following,
  });

  static User fromSnap(DocumentSnapshot snap) {  // "fromSnap" is user define function name
    var snapshot = snap.data() as Map<String , dynamic>;

    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      following: snapshot['following'],
      followers: snapshot['followers'],
      bio: snapshot['bio'],
    );
  }

  Map<String , dynamic> toJson() => {
    "username": username,
    "uid": uid,
    "email": email,
    "bio": bio,
    "followers": followers,
    "following": following,
    "photoUrl" : photoUrl,
  };

}