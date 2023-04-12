import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'ForgotPassword.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback? onClickedSignUp;
  const LoginWidget({Key? key, this.onClickedSignUp}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // TextEditingController emailController1 = TextEditingController();
  // TextEditingController passwordController1 = TextEditingController();

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            const FlutterLogo(
              size: 120,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Hey There,\n Welcome Back',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Email'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? 'Enter a valid email'
                      : null,
            ),
            const SizedBox(
              height: 4,
            ),
            TextField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              icon: const Icon(
                Icons.lock_open,
                size: 32,
              ),
              label: const Text(
                'Log In',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () {
                signIn();
              },
            ),
            const SizedBox(
              height: 24,
            ),
            GestureDetector(
              child: const Text(
                'Forgot password?',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ForgotPassword()));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                  text: "Don't have an account? ",
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                        text: "Sign Up",
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => widget.onClickedSignUp!())
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
