import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shirt_project/Providers/BottomBarProvider.dart';
import 'package:shirt_project/Screens/Authentiation.dart';
import 'package:shirt_project/Screens/History.dart';
import 'package:shirt_project/Screens/SecondScreen.dart';
import 'Screens/Account.dart';
import 'Screens/HomePage.dart';
import 'Screens/SplashScreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(
        duration: 2,
        gotoPage: const UserAuthentication(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        home: MyHome(),
        debugShowCheckedModeBanner: false,
      ),
      providers: [
        ChangeNotifierProvider(create: (context) => BottomBarprovider())
      ],
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  late History history;
  late Accounts account;
  late HomePage homePage;

  late List<Widget> pages = [
    HomePage(),
    History(),
    Accounts(),
  ];
  late Widget currentPage;
  void initState() {
    currentPage = HomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final NavBarProvider =
        Provider.of<BottomBarprovider>(context, listen: false);
    print('build called');
    return Consumer<BottomBarprovider>(
        builder: (BuildContext context, value, Widget? child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Guess App'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: value.currentIndex,
          onTap: (int index) {
            value.changeIndex(index);
          },
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'History'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_outlined), label: 'Account')
          ],
        ),
        body: pages[value.currentIndex],
      );
    });
  }
}
