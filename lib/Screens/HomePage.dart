import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'SecondScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var categoryList;

  Future<void> allCategories() async {
    var mytemp =
        await FirebaseFirestore.instance.collection('/Categories').get();
    List<Map<String, dynamic>> list1 =
        mytemp.docs.map((doc) => doc.data()).toList();
    categoryList = list1;
    setState(() {});
  }

  Future addHistory(String result, String category) async {
    await FirebaseFirestore.instance.collection('history').add({
      'user_id': FirebaseAuth.instance.currentUser?.uid,
      'category': category,
      'result': result,
      'time': DateTime.now().toString(),
    });
  }

  @override
  void initState() {
    allCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 20),
        child: (categoryList != null)
            ? Container(
                child: GridView.count(
                  crossAxisCount: (2),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 2, top: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(
                    categoryList.length,
                    (index) => Container(
                      child: GestureDetector(
                        onTap: () {
                          int length = categoryList[index]['colors'].length;
                          var random = Random();
                          int randomNumber = random.nextInt(length);
                          setState(() {
                            addHistory(
                              categoryList[index]['colors'][randomNumber],
                              categoryList[index]['title'],
                            );
                          });

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondScreen(
                                      colorString: categoryList[index]['colors']
                                          [randomNumber],
                                    )),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.black54,
                                  width: 1,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black45,
                                    offset: Offset(
                                      2.0,
                                      2.0,
                                    ), //Offset
                                    blurRadius: 4.0,
                                    spreadRadius: 1.0,
                                  )
                                ],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                child: Container(
                                  width: 125,
                                  height: 125,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      // image: NetworkImage(categoryList[index]
                                      //         ['image']
                                      //     .toString()),
                                      image: AssetImage('assets/circle.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Spark',
                                // categoryList[index]['title'],
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).reversed.toList(),
                ),
              )
            : Container(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
                // child: LoadingAnimationWidget.twistingDots(
                //   leftDotColor: const Color(0xFF1A1A3F),
                //   rightDotColor: const Color(0xFFEA3799),
                //   size: 200,
                // ),
              ),
      ),
    );
  }
}
