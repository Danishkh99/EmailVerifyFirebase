import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';
import 'AuthPage.dart';
import 'LoginWidget.dart';
import 'VerifyEmailPage.dart';

class UserAuthentication extends StatefulWidget {
  const UserAuthentication({super.key});

  @override
  State<UserAuthentication> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<UserAuthentication> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          } else if (snapshot.hasData) {
            // return const MyHomePage(title: 'Home');
            return const VerifyEmailPage();
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
