import 'package:flutter/material.dart';
import 'package:remoteta_app/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:remoteta_app/screens/login.dart';
import 'package:remoteta_app/services/firebase_auth_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

Future<void> _signOut(BuildContext context) async {
  try {
    final _auth = Provider.of<FirebaseAuthService>(context, listen: false);
    await _auth.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  } catch (e) {
    print(e);
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        automaticallyImplyLeading: false,
        backgroundColor: kAppBarBackgroundColor,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Logout",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _confirmLogOut(context),
          ),
        ],
      ),
    );
  }
}

void _confirmLogOut(BuildContext context) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Confirmation"),
        content: new Text("Are you sure you want to log out?"),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text(
              "Close",
              style: TextStyle(color: kLinkColor),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            child: new Text(
              "Logout",
              style: TextStyle(color: kLinkColor),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              _signOut(context);
            },
          ),
        ],
      );
    },
  );
}
