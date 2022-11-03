import 'package:flutter/material.dart';

class IdeasScreen extends StatefulWidget {
  const IdeasScreen({Key? key}) : super(key: key);

  @override
  State<IdeasScreen> createState() => _IdeasScreenState();
}

class _IdeasScreenState extends State<IdeasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('Hiii'),
      ),
    );
  }
}
