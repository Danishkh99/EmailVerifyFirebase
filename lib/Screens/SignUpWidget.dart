import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  final Function? onClickedSignIn;

  const SignUp({super.key, this.onClickedSignIn});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController1 = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  dispose() {
    emailController1.dispose();
    passwordController1.dispose();
    super.dispose();
  }

  Future addUserDetails() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'firstName': firstNameController.text.trim(),
      'lastName': lastNameController.text.trim(),
      'email': emailController1.text.trim(),
    });
  }

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController1.text.trim(),
          password: passwordController1.text.trim());
      addUserDetails();
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 45,
              ),
              const FlutterLogo(
                size: 110,
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
                height: 20,
              ),
              TextFormField(
                controller: firstNameController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) => value != null && value.isEmpty
                    ? 'Please enter your first name'
                    : null,
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                controller: lastNameController,
                textInputAction: TextInputAction.done,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) => value != null && value.isEmpty
                    ? 'Please enter your last name'
                    : null,
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                controller: emailController1,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Email'),
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        : null,
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                controller: passwordController1,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? 'Password must be at least 6 characters'
                    : null,
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                controller: confirmPasswordController,
                textInputAction: TextInputAction.done,
                decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != passwordController1.text
                    ? 'Passwords do not match'
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                icon: const Icon(
                  Icons.lock_open,
                  size: 32,
                ),
                label: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    signUp();
                  }
                },
              ),
              const SizedBox(
                height: 24,
              ),
              RichText(
                text: TextSpan(
                    text: "Already have an account? ",
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                          text: "Log In",
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => widget.onClickedSignIn?.call())
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
