import 'package:children_now/models/user.dart' as Client;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  static Future<Client.User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      User? tmp = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      Client.User? result = await Client.User.getUser(tmp!.uid);
      if(result != null) {
        return result;
      } else {
        return await Client.User.createUser(tmp.uid, tmp.email!, tmp.displayName, tmp.photoURL, tmp.phoneNumber);
      }
    } catch (e) {
      return null;
    }
  }

  static Future<Client.User?> registerUser(String email, String password) async {
    try {
      UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return await Client.User.createUser(result.user!.uid, result.user!.email!, null, null, null);
    } catch (e) {
      return null;
    }
  }

  static Future<Client.User?> signInWhitEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return await Client.User.getUser(result.user!.uid);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  static User? get currentUser {
    return FirebaseAuth.instance.currentUser;
  }

  static Future<void> logOut() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.signOut();
  }
  
}