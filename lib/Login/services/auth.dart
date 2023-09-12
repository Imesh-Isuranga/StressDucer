import 'package:firebase_auth/firebase_auth.dart';
import 'package:stress_ducer/Login/model/UserModel.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stress_ducer/Login/services/error.dart';


class AuthServices {
  //firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  //create a user from firebase user with uid
  UserModel? _userWithFirebaseUserUid(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  //create the stream for checking the auth changes in the user
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userWithFirebaseUserUid);
  }

Future<void> deleteAccount() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.delete();
      print('User account deleted');
    } else {
      print('No user signed in');
    }
  } catch (e) {
    print('Error deleting account: $e');
  }
}



//check only google sign in emails
  Future checkIfEmailExists(String email) async {
    try {
      List<String> signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      if (signInMethods.contains("google.com")) {
        print("Email is already associated with a Google Sign-In account.");
        return "0";
      } else {
        print("Email is not associated with any account.");
        return "1";
      }
    } catch (error) {
      return "Error checking email existence: $error";
    }
  }

//This is for google sign in
  Future handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      List<String> signInMethods = await FirebaseAuth.instance
          .fetchSignInMethodsForEmail(googleSignInAccount!.email);
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential authResult =
            await _auth.signInWithCredential(credential);
      }
      if (signInMethods.contains("google.com")) {
        print("Email is already associated with a Google Sign-In account.");
        return "0";
      } else {
        print("Email is not associated with any account.");
        return "1";
      }
    } catch (error) {
      print("Error during Google sign-in: $error");
    }
  }

  //Sign in anonymous
  Future signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userWithFirebaseUserUid(user);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  //register using email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userWithFirebaseUserUid(user);
    } catch (err) {
      Error().setError(err.toString());
      return null;
    }
  }

  //signin using email and password
  Future signInUsingEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userWithFirebaseUserUid(user);
    } catch (err) {
      Error().setError(err.toString());
      print(err.toString());
      return null;
    }
  }

  //signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (err) {
      print(err.toString());
      return null;
    }
  }
}
