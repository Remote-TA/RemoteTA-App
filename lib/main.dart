import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remoteta_app/screens/welcome.dart';
import 'package:remoteta_app/services/firebase_auth_service.dart';
import 'package:remoteta_app/services/firestore_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(),
        ),
        Provider<FirestoreService>(
          create: (_) => FirestoreService(),
        )
      ],
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
          title: 'RemotaTA',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: WelcomeScreen(),
        ),
      ),
    );
  }
}
