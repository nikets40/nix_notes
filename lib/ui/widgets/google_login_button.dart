import 'package:flutter/material.dart';
import 'package:nix_notes/core/services/auth_service.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100)),
        onPressed: AuthService.instance.signInWithGoogle,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 15, horizontal: 20),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  "assets/images/google_icon.png",
                  height: 24,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Continue with Google",
                    textScaleFactor: 1.4,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.6)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
