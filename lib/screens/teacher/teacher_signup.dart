import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remoteta_app/components/rounded_button.dart';
import 'package:remoteta_app/screens/teacher/teacher_login.dart';
import '../../constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:remoteta_app/services/firebase_auth_service.dart';
import 'package:remoteta_app/services/firestore_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TeacherSignUpScreen extends StatefulWidget {
  @override
  _TeacherSignUpScreenState createState() => _TeacherSignUpScreenState();
}

class _TeacherSignUpScreenState extends State<TeacherSignUpScreen> {
  final key = GlobalKey<FormState>();
  String fullName, prefix, email, password, confirmationPassword, grade, school;
  List<String> _gradeLevels = ['9th', '10th', '11th', '12th'];
  List<DropdownMenuItem<String>> _gradeItems;
  String _selectedGrade;

  List<String> _prefixes = ['Ms', 'Mrs', 'Mr'];
  List<DropdownMenuItem<String>> _prefixItems;
  String _selectedPrefix;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedGrade = _gradeLevels[0];
    _gradeItems = _buildDropdownMenuItems(_gradeLevels);

    _selectedPrefix = _prefixes[0];
    _prefixItems = _buildDropdownMenuItems(_prefixes);
  }

  List<DropdownMenuItem<String>> _buildDropdownMenuItems(
      List<String> listItems) {
    List<DropdownMenuItem<String>> items = List();
    for (int i = 0; i < listItems.length; i++) {
      items.add(
        new DropdownMenuItem(
          value: listItems[i],
          child: Text(listItems[i]),
        ),
      );
    }
    return items;
  }

  void onChangeDropdownGradeItem(String s) {
    setState(() {
      _selectedGrade = s;
      grade = _selectedGrade;
    });
  }

  void onChangeDropdownPrefixItem(String s) {
    setState(() {
      _selectedPrefix = s;
      prefix = _selectedPrefix;
    });
  }

  Future<void> createUserWithEmailAndPassword(BuildContext context) async {
    if (key.currentState.validate()) {
      final auth = Provider.of<FirebaseAuthService>(context, listen: false);
      try {
        final user = await auth.createUserWithEmailAndPassword(email, password);
        FirebaseUser firebaseUser = user.userFromFirebase;
        // Send Email Verification Here

        try {
          final res = await firebaseUser.sendEmailVerification();
          _showEmailConfirmationMessage(context, firebaseUser.email);
        } catch (err) {
          print('error sending verification email ' + err.code);
        }

        final firestore = Provider.of<FirestoreService>(context, listen: false);
        List nameItems = this.fullName.trim().split(" ");

        firestore.updateTeacherUserData(
          uid: user.uid,
          email: this.email,
          firstName: nameItems[0],
          lastName: nameItems[1],
          preferredPrefix: prefix,
          activeProjects: [],
          pendingProjects: [],
          reviewProjects: {},
          grade: grade,
          school: school,
          userType: 'teacher',
        );

//        if (user != null) {
//          Navigator.push(
//            context,
//            MaterialPageRoute(
//              builder: (context) => HomeScreen(),
//            ),
//          );
//        }
      } catch (e) {
        print(e.code);
        _onAlertWithCustomImagePressed(
          context,
          'Error',
          auth.convertFirebaseErrorToMessage(e.code),
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

  void _showEmailConfirmationMessage(BuildContext context, String email) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Email Confirmation Verification"),
          content: new Text(
              "An email was sent to $email. Please check your email to get verified into RemoteTA"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Return to Login"),
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => TeacherLoginScreen(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RemoteTA Teacher'),
        automaticallyImplyLeading: true,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            'assets/logo.png',
                            width: MediaQuery.of(context).size.width / 5,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.52,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'RemoteTA',
                                  style: TextStyle(fontSize: 30.0),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 12.0),
                                child: Text(
                                  'An Online Volunteering Platform for High School Students',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: kSmallDescriptionColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1.0,
                              color: Color.fromARGB(255, 9, 132, 227),
                            ),
                          ),
                        ),
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                            fontSize: 25.0,
                            letterSpacing: 1.0,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please enter some text';
                      }
//                      else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]')
//                          .hasMatch(val)) {
//                        return 'Please enter a valid first name';
//                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    cursorColor: kInputOutlineColor.withOpacity(0.7),
                    onChanged: (value) {
                      fullName = value;
                    },
                    decoration: kInputDecoration.copyWith(
                      hintText: 'First & Last Name',
                      prefixIcon: Icon(
                        Icons.person,
                        color: kInputOutlineColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please enter your school email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      school = value;
                    },
                    decoration: kInputDecoration.copyWith(
                      hintText: 'Enter your school email',
                      prefixIcon: Icon(
                        Icons.email,
                        color: kInputOutlineColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please enter the school you are teaching at';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kInputDecoration.copyWith(
                      hintText: 'Enter your school',
                      prefixIcon: Icon(
                        Icons.email,
                        color: kInputOutlineColor,
                      ),
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
                      hintText: 'Enter your password',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: kInputOutlineColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please enter your password";
                      } else if (val != this.password) {
                        return "Passwords don't match";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    obscureText: true,
                    onChanged: (value) {
                      confirmationPassword = value;
                    },
                    decoration: kInputDecoration.copyWith(
                      hintText: 'Re-enter your password',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: kInputOutlineColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("Grade: "),
                          SizedBox(
                            width: 10.0,
                          ),
                          DropdownButton(
                            value: _selectedGrade,
                            items: _gradeItems,
                            onChanged: onChangeDropdownGradeItem,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Preferred Prefix: "),
                      SizedBox(
                        width: 10.0,
                      ),
                      DropdownButton(
                        value: _selectedPrefix,
                        items: _prefixItems,
                        onChanged: onChangeDropdownPrefixItem,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  RoundedButton(
                    text: "Sign Up",
                    color: kSignUpButtonColor,
                    onPress: () {
                      createUserWithEmailAndPassword(context);
                    },
                  ),
//                  Container(
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        Text("Already have an account? "),
//                        GestureDetector(
//                          onTap: () {
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                builder: (context) => LoginScreen(),
//                              ),
//                            );
//                          },
//                          child: Text(
//                            "Login",
//                            style: TextStyle(color: kLinkColor),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
