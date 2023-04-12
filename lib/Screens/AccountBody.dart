import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AccountBody extends StatefulWidget {
  const AccountBody({super.key});

  @override
  State<AccountBody> createState() => _AccountBodyState();
}

class _AccountBodyState extends State<AccountBody> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(children: [
              Row(
                children: const [
                  Icon(
                    Icons.person,
                    color: Colors.blueGrey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                      // currentUser.uname,
                      'Name',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      )),
                ],
              ),
              const Divider(
                color: Colors.black87,
                thickness: 1,
                height: 20,
                indent: 10,
                endIndent: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.email,
                    color: Colors.blueGrey,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    // currentUser.email,
                    user.email!,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.black87,
                thickness: 1,
                height: 20,
                indent: 10,
                endIndent: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  // Navigator.pushAndRemoveUntil(context,
                  //     MaterialPageRoute(builder: (BuildContext context) {
                  //   return HomePage();
                  // }), (r) {
                  //   return false;
                  // });
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.logout,
                      color: Colors.blueGrey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    // ),
                  ],
                ),
              ),
            ])));
    ;
  }
}
