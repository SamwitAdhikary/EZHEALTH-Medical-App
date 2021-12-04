import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationProvider {
  final FirebaseAuth firebaseAuth;

  AuthenticationProvider(this.firebaseAuth);

  Stream<User> get authState => firebaseAuth.idTokenChanges();

  //! Singup Method
  Future<void> signUp({String email, String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<void> signIn({String email, String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
