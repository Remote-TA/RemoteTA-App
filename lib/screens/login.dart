import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remoteta_app/constants/constants.dart';
import 'package:remoteta_app/components/rounded_button.dart';
import 'package:remoteta_app/screens/home.dart';
import 'package:remoteta_app/screens/signup.dart';
import 'package:provider/provider.dart';
import 'package:remoteta_app/services/firebase_auth_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:io' show Platform;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final key = GlobalKey<FormState>();
  final resetKey = GlobalKey<FormState>();

  String email, password, emailForReset;
  String errorMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _signIn(BuildContext context) async {
    final auth = Provider.of<FirebaseAuthService>(context, listen: false);
    if (key.currentState.validate()) {
      try {
        final user = await auth.signInWithEmailAndPassword(email, password);

        if(user.userFromFirebase.isEmailVerified) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        } else {
          _promptVerifyEmail(context, user.userFromFirebase);
        }
      } catch (error) {
        print(error.code);
        _onAlertWithCustomImagePressed(
          context,
          "Error",
          auth.convertFirebaseErrorToMessage(error.code),
        );
      }
    }
  }

  _onAlertWithCustomImagePressed(context, dynamic title, dynamic description) {
    Alert(
      context: context,
      title: title,
      desc: description,
      image: Image.asset(
        "assets/cancel.png",
        width: 100.0,
      ),
    ).show();
  }

  void _promptVerifyEmail(BuildContext context, FirebaseUser scopedFirebaseUser) {
    String email = scopedFirebaseUser.email;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Please verify your email"),
          content: new Text(
              "Please verify your email at ${email} and then log into RemoteTA 📚"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Got it!"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            new FlatButton(
              child: new Text("Resend Verification email!"),
              onPressed: () async {
                await scopedFirebaseUser.sendEmailVerification();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _sendPasswordResetEmail(BuildContext context) async {
    final bool validEmail = EmailValidator.validate(this.emailForReset);
    if (this.emailForReset != '' && validEmail) {
      final auth = Provider.of<FirebaseAuthService>(context, listen: false);

      try {
        await auth.sendPasswordResetEmail(this.emailForReset);
      } catch (error) {
        print(error.code);
      }
    }
  }

  _passwordResetDialog(context) {
    Alert(
      context: context,
      title: "Password Reset",
      content: Column(
        children: <Widget>[
          SizedBox(height: 10.0),
          Form(
            key: resetKey,
            child: TextFormField(
              validator: (val) {
                if (val.isEmpty) {
                  return "Please enter your password";
                }
                return null;
              },
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              obscureText: false,
              onChanged: (value) {
                emailForReset = value;
              },
              decoration: InputDecoration(hintText: 'Enter Email'),
              initialValue: this.email,
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            if (resetKey.currentState.validate()) {
              _sendPasswordResetEmail(context);
              Navigator.pop(context);
            }
          },
          child: Text(
            "Reset Password",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress)
          return false;
        else
          return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Log In'),
          automaticallyImplyLeading: false,
          backgroundColor: kAppBarBackgroundColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: key,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset(
                              'assets/logo.png',
                              width: MediaQuery.of(context).size.width / 3,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'RemoteTA',
                                  style: TextStyle(fontSize: 30.0),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                margin: EdgeInsets.only(left: 12.0),
                                child: Text(
                                  'An Online Volunteering Platform for High School Students',
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      color: kSmallDescriptionColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Platform.isIOS
                          ? MediaQuery.of(context).size.height / 10
                          : MediaQuery.of(context).size.height / 20,
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: kInputDecoration.copyWith(
                        prefixIcon: Icon(
                          Icons.email,
                          color: kInputOutlineColor,
                        ),
                        hintText: 'Enter your email',
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: kInputDecoration.copyWith(
                          prefixIcon: Icon(
                            Icons.lock,
                            semanticLabel: 'Email',
                            color: kInputOutlineColor,
                          ),
                          hintText: 'Enter your password'),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    RoundedButton(
                      text: "Sign Up",
                      color: kSignUpButtonColor,
                      onPress: () {
                        _signIn(context);
                      },
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account? Sign up "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "here.",
                              style: TextStyle(color: kLinkColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: MaterialButton(
                        onPressed: () {
                          _passwordResetDialog(context);
                        },
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(color: kLinkColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
