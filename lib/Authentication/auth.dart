import 'package:firebase_auth/firebase_auth.dart';

class Users{
  final String uid;

  Users({required this.uid});
}

class Auth{

  final authResult = FirebaseAuth.instance;

  Users? _userFromFirebase(User user)
  {
    if(user == null)
      {
        return null;
      }
    return Users(uid: user.uid);
  }

  Future<Users?> signInWithEmailAddress(String email, String password) async
  {
    final user = await authResult.signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(user.user!);
  }

  Future<Users?> createAccountWithEmailAddress(String email, String password) async
  {
    final user = await authResult.createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(user.user!);
  }

  Stream<Users?> get onAuthStateChange{
    return authResult.authStateChanges().map((user) => _userFromFirebase(user!));
  }

  Future<void> signOut() async
  {
     authResult.authStateChanges().map((user) => _userFromFirebase(user!));
    await authResult.signOut();
  }

}