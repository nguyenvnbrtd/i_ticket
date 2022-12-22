import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  FirebaseAuth? _firebaseAuth;

  UserRepository() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  Future<UserCredential?> logIn(String email, String password) async {
    return await _firebaseAuth?.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential?> signIn(String email, String password) async {
    return await _firebaseAuth?.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> changePassword(String password) async {
    final user = await getUser();
    await user?.updatePassword(password);
  }

  Future<void> logOut() async {
    return await _firebaseAuth?.signOut();
  }

  bool isLogIn() {
    return _firebaseAuth != null;
  }

  Future<void> sendResetCode(String email) async {
    await _firebaseAuth?.sendPasswordResetEmail(email: email);
  }

  Future<void> verifyCode(String email) async {

  }

  Future<void> resetPassword(String email) async {

  }

  Future<User?> getUser() async {
    try {
      return _firebaseAuth?.currentUser;
    } catch (e) {
      return null;
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return _firebaseAuth?.currentUser.toString() ?? "none";
    // return super.toString();
  }
}
