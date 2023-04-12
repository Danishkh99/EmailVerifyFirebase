import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SecondScreen extends StatefulWidget {
  final String colorString;
  const SecondScreen({super.key, this.colorString = ""});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool _isLoading = false;
  Future putDelay() async {
    await new Future.delayed(new Duration(seconds: 2));
  }

  @override
  void initState() {
    _isLoading = true;
    putDelay().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen"),
      ),
      body: Center(
        child: !_isLoading
            ? Text(
                widget.colorString,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )
            : LoadingAnimationWidget.inkDrop(
                color: Color.fromARGB(255, 18, 87, 200),
                size: 50,
              ),
      ),
    );
  }
}
