import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shirt_project/main.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = true;
  var timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      setState(() {
        canResendEmail = false;
        Timer(Duration(seconds: 10), () {
          setState(() {
            canResendEmail = true;
          });
        });
      });
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (isEmailVerified) {
      timer?.cancel();
      Fluttertoast.showToast(msg: "Email Verified");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MyHomePage(title: 'Home'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const MyHomePage(title: 'Home')
      : Scaffold(
          appBar: AppBar(
            title: const Text("Verify Email"),
          ),
          body: Center(
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.only(top: 40, bottom: 20),
                child: Text("Please verify your email",
                    style: TextStyle(fontSize: 20)),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  canResendEmail
                      ? sendVerificationEmail()
                      : Fluttertoast.showToast(msg: 'wait for 10 seconds');
                },
                icon: const Icon(Icons.email),
                label: const Text(
                  'Resend Email',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
              ),
              TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ))
            ]),
          ),
        );
}
