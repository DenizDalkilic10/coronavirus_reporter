import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorldPage extends StatefulWidget {
  WorldPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WorldPageState createState() => _WorldPageState();
}

class _WorldPageState extends State<WorldPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }
}