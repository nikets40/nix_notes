import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nix_notes/core/services/db_service.dart';
import 'package:nix_notes/ui/screens/home_screen.dart';
import 'package:nix_notes/ui/screens/onboarding.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class AuthService {
  static AuthService instance = AuthService();

  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),),),
            );
          }

          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return OnBoardingScreen();
          }
        });
  }

  signIn(AuthCredential credential) async {
    var user = await FirebaseAuth.instance.signInWithCredential(credential);
    DBService.instance.createUserInDB(user.user);
  }

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    signIn(credential);
  }

  Future signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken.token);

    // Once signed in, return the UserCredential
    var user = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    DBService.instance.createUserInDB(user.user);
  }
}
