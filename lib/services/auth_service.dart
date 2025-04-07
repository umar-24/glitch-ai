import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google sign in 
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Configure GoogleSignIn instance with scopes if necessary
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );

      // Begin Sign in interactive process  
      final GoogleSignInAccount? gUser = await googleSignIn.signIn(); 

      // Check if the user canceled the sign-in
      if (gUser == null) {
        return null;  // Sign-in canceled by the user
      }

      // Obtain authentication details from the Google Sign-In request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create a new credential from the authentication details
      final credential = GoogleAuthProvider.credential(
        idToken: gAuth.idToken,
        accessToken: gAuth.accessToken,
      );

      // Sign in using the credential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // Handle errors (e.g., network issues)
      print('Error during Google sign-in: $e');
      return null; // Return null if there's an error
    }
  }
}