import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shirt_project/Screens/SignUpWidget.dart';

import 'ForgotPassword.dart';
import 'LoginWidget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool isLogin = true;


  void toggle() => setState(() {
        isLogin = !isLogin;
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLogin
          ? LoginWidget(
              onClickedSignUp: toggle,
            )
          : SignUp(
              onClickedSignIn: toggle,
            ),
    );
  }
}
