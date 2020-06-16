import 'package:flutter/material.dart';
import 'package:remoteta_app/constants/constants.dart';
import 'package:remoteta_app/screens/login.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Color.fromARGB(255, 9, 132, 227),
            Color.fromARGB(255, 9, 132, 227).withOpacity(0.8),
            Color.fromARGB(255, 9, 132, 227).withOpacity(0.6),
            Color.fromARGB(255, 9, 132, 227).withOpacity(0.4),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height / 10),
                Container(
                  height: MediaQuery.of(context).size.height / 1.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Welcome to',
                              style: kHeaderTextStyle,
                            ),
                            Text(
                              'RemoteTA!',
                              style: kHeaderTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/welcome.png',
                        width: MediaQuery.of(context).size.width / 2.5,
                      ),
                      Column(
                        children: <Widget>[
                          MaterialButton(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Text('Continue As a Student ↪'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 5.0),
                          MaterialButton(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Text('Continue As a Teacher ↪'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
