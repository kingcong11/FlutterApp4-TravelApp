import 'package:flutter/material.dart';

class MyDestinationsScreen extends StatefulWidget {
  /* Properties */
  static const routeName = '/my-destination';

  @override
  _MyDestinationsScreenState createState() => _MyDestinationsScreenState();
}

class _MyDestinationsScreenState extends State<MyDestinationsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text('bruh'),
      ),
    );
  }
}
