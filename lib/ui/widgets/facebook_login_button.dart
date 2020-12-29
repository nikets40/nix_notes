import 'package:flutter/material.dart';
import 'package:nix_notes/core/services/auth_service.dart';

class FacebookLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      onPressed: AuthService.instance.signInWithFacebook,
      color: Color(0xff1778F2),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 5),
        child: Row(
          children: [
            Image.asset(
              "assets/images/facebook_icon.png",
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Continue with Facebook",
                textScaleFactor: 1.4,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.9)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
