import 'package:flutter/material.dart';
class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "FirstPage",
      home: Scaffold(
          body: Center(
            child: Text("test"),
          )
      ),
    );
  }
}

