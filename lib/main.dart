import 'package:brewcrew/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:brewcrew/shared/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user_model.dart';
import 'services/auth.dart';

void clear() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    clear();
    return StreamProvider<UserModel>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: Wrapper(),
      ),
      catchError: (_, __) => null,
    );
  }
}
