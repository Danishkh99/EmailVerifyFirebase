import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'AccountBody.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  final user = FirebaseAuth.instance.currentUser!;
  List<Map<String, dynamic>> users = [];

  Future<void> allCategories() async {
    var mytemp = await FirebaseFirestore.instance.collection('/users').get();
    List<Map<String, dynamic>> list1 =
        mytemp.docs.map((doc) => doc.data()).toList();
    users = list1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            Container(
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            Positioned(
              // top: 20,
              // left: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile.png'),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        // currentUser.uname,
                        'Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      // Text(
                      //   // currentUser.email,
                      //   user.email!,
                      //   style: const TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 15,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => EditUserDetailView(
                        //       name: currentUser.uname,
                        //       email: currentUser.email,
                        //       phone: currentUser.contact_no,
                        //       address: currentUser.address,
                        //       city: currentUser.city,
                        //     ),
                        //   ),
                        // );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const AccountBody(),
      ],
    ));
  }
}
