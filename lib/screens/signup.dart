import 'package:flutter/material.dart';
import 'package:remoteta_app/components/rounded_button.dart';
import 'constants/constants.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final key = GlobalKey<FormState>();
  String fullName, email, password, confirmationPassword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 116, 185, 255),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
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
                      Column(
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
                              'Description...',
                              style: TextStyle(fontSize: 10.0),
                            ),
                          ),
                        ],
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
                    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]')
                        .hasMatch(val)) {
                      return 'Please enter a valid first name';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  cursorColor: kInputOutlineColor.withOpacity(0.7),
                  onChanged: (value) {
                    fullName = value;
                  },
                  decoration: kInputDecoration.copyWith(hintText: 'Full Name'),
                ),
                SizedBox(height: 8.0),
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
                      hintText: 'Enter your password'),
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
                    confirmationPassword = value;
                  },
                  decoration: kInputDecoration.copyWith(
                      hintText: 'Re-enter your password'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                RoundedButton(
                  text: "Sign Up",
                  color: kSignUpButtonColor,
                  onPress: () {
                    print(this.email);
                    print(this.fullName);
                    print(this.password);
                    print(this.confirmationPassword);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
