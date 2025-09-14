import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationUseCases {
  AuthenticationUseCases();

  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    return;
  }

  Future<void> signup(String userName, String email, String password) async {
    final user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    if (user.user == null) {
      throw Exception('User not created');
    }

    await FirebaseFirestore.instance.collection('users').doc(user.user!.uid).set({
      'id': user.user!.uid,
      'userName': userName,
      'email': email,
    });

    return;
  }
}
