import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nix_notes/core/services/auth_service.dart';
import 'package:nix_notes/ui/screens/home_screen.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var screenHeight;
  var screenWidth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: screenWidth * 0.8,
                      width: screenWidth * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage('assets/logo/logo.png'))),
                    ),
                    SizedBox(height: 20,),
                    RichText(
                      text: TextSpan(
                        text: 'Stiky ',
                        style: TextStyle(fontSize: 42,fontWeight: FontWeight.bold,color:Color(0xffFFBE00) ),
                        children: <TextSpan>[
                          TextSpan(text: 'Notes', style: TextStyle(fontWeight: FontWeight.normal,color: Color(0xffFFEC00))),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: LoginPanel(),
                )),

            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}

class LoginPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0, left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "Continue with",
            //   textScaleFactor: 1.8,
            //   style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),
            // ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Column(
                children: [
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: AuthService.instance.signInWithGoogle,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/google_icon.png",
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              "Continue with Google",
                              textScaleFactor: 1.4,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
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
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'By signing in you agree to our ',
                      style: TextStyle(color: Colors.white.withOpacity(0.6)),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'terms and conditions',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold)),
                        TextSpan(text: ' and '),
                        TextSpan(
                            text: 'privacy policy',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  gotoHomeScreen(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
